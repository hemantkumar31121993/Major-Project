/*

Copyright 1989, 1998  The Open Group

Permission to use, copy, modify, distribute, and sell this software and its
documentation for any purpose is hereby granted without fee, provided that
the above copyright notice appear in all copies and that both that
copyright notice and this permission notice appear in supporting
documentation.

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
OPEN GROUP BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

Except as contained in this notice, the name of The Open Group shall not be
used in advertising or otherwise to promote the sale, use or other dealings
in this Software without prior written authorization from The Open Group.
 * *
 * Author:  Ralph Swick, DEC/Project Athena
 * Updated for R4:  Chris D. Peterson,  MIT X Consortium.
 * Reauthored by: Keith Packard, MIT X Consortium.
 * UTF-8 and CTEXT support: Stanislav Maslovski <stanislav.maslovski@gmail.com>
 */

#ifdef HAVE_CONFIG_H
#include "config.h"
#endif

#include <stdio.h>
#include <X11/Intrinsic.h>
#include <X11/StringDefs.h>
#include <X11/Xatom.h>

#include <X11/Xmu/Atoms.h>
#include <X11/Xmu/StdSel.h>

#include <X11/Shell.h>
#include <X11/Xaw/Form.h>
#include <X11/Xaw/Label.h>
#include <X11/Xaw/Command.h>
#include <X11/Xaw/AsciiText.h>
#include <X11/Xaw/Dialog.h>
#include <X11/Xaw/Cardinals.h>
#include <X11/IntrinsicP.h>
#include <X11/Xaw/TextP.h>
#include <X11/Xfuncs.h>

#ifdef XKB
#include <X11/extensions/XKBbells.h>
#endif

#include <stdlib.h>
#include <time.h>

#define Command commandWidgetClass
#define Label	labelWidgetClass
#define Text    asciiTextWidgetClass

#define INFINITY 10000000	/* pretty big, huh? */

typedef struct _Requestor {
	Window 		window;
	char 		*name;
	Window 		supportWindow;
	char 		*supportWindowName;
	char* 		target_string;
	time_t 		timestamp;

	struct _Requestor *next;
} Requestor ,*RequestorPtr;

typedef struct _Clip {
    struct _Clip    *next, *prev;
    char	    *clip;
    char	    *filename;
    int		    avail;

	//Owner Information
	Window		window;
	char 		**win_info_list;
	int			win_info_length;
	Window		supportWindow;
	char*		supportWindowName;
	time_t		timestamp;

	//Requestor Information
	RequestorPtr requestors;
	
} ClipRec, *ClipPtr;

void addRequestor(ClipPtr ptr, Window window, char * name, Window supportWindow, char * supportWindowName, char * target_string) {
	RequestorPtr newRequestor = (RequestorPtr)malloc(sizeof(Requestor));
	newRequestor->window = window;
	newRequestor->name = name;
	newRequestor->supportWindow = supportWindow;
	newRequestor->supportWindowName = supportWindowName;
	newRequestor->target_string = target_string;
	newRequestor->timestamp = time(NULL);
	newRequestor->next = ptr->requestors;
	ptr->requestors = newRequestor;
}

static Atom wm_delete_window;
static Atom wm_protocols;

static void EraseTextWidget ( void );
static void NewCurrentClipContents ( char *data, int len, Window window, char **win_info_list, int win_info_length, Window supportWindow, char *supportWindowName);
int GetWindowInfo(Display *d, Window window, char ***win_info_list_ptr, int *win_info_length_ptr);

static String fallback_resources[] = {
    "*international: true",
    NULL
};

static long 
TextLength(Widget w)
{
    return XawTextSourceScan (XawTextGetSource (w),
			      (XawTextPosition) 0,
 			      XawstAll, XawsdRight, 1, TRUE);
}

static void
SaveClip(Widget w, ClipPtr clip)
{
    Arg	    args[1];
    char    *data;
    int	    len;
    Widget  source;

    source = XawTextGetSource (w);
    XtSetArg (args[0], XtNstring, &data);

    len = strlen (data);
    if (len >= clip->avail)
    {
	if (clip->clip)
	    free (clip->clip);
	clip->clip = malloc (len + 1);
	if (!clip->clip)
	    clip->avail = 0;
	else
	    clip->avail = len + 1;
    }
    if (clip->avail)
    {
	strcpy (clip->clip, data);
    }
}

static void
RestoreClip(Widget w, ClipPtr clip)
{
    Arg	    args[1];
    Widget  source;

    source = XawTextGetSource (w);
    XtSetArg (args[0], XtNstring, clip->clip);
    XtSetValues (source, args, 1);
}

/*ARGSUSED*/
static ClipPtr 
NewClip(Widget w, ClipPtr old, char *clip, Window window, char** win_info_list, int win_info_lenght, Window supportWindow, char * supportWindowName)
{

    ClipPtr newClip;

    newClip = (ClipPtr) malloc (sizeof (ClipRec));
    if (!newClip)
		return newClip;

	newClip->clip = (char *)malloc(sizeof(char) * (strlen(clip) + 1));
	
	strcpy(newClip->clip,clip);
	newClip->avail = 0;
    newClip->prev = old;
    newClip->next = NULL;
    newClip->filename = NULL;
	newClip->window = window;
	newClip->win_info_list = win_info_list;
	newClip->win_info_length = win_info_lenght;
	newClip->supportWindow = supportWindow;
	newClip->supportWindowName = supportWindowName;
	newClip->timestamp = time(NULL);
	newClip->requestors = NULL;

    if (old)
    {
		newClip->next = old->next;
		old->next = newClip;
    }

    return newClip;
}

/*ARGSUSED*/
static void
DeleteClip(Widget w, ClipPtr clip)
{
    if (clip->prev)
	clip->prev->next = clip->next;
    if (clip->next)
	clip->next->prev = clip->prev;
    if (clip->clip)
	free (clip->clip);
    free ((char *) clip);
}

static ClipPtr	currentClip;
static Widget	top;
static Widget	text, nextButton, prevButton, indexLabel;
static Widget	fileDialog, fileDialogShell;
static Widget	failDialog, failDialogShell;

static int
IndexCurrentClip (void)
{
    int	i = 0;
    ClipPtr clip;

    for (clip = currentClip; clip; clip = clip->prev)
		i++;
    return i;
}

static void
set_button_state (void)
{
    Boolean prevvalid, nextvalid;
    Arg arg;
    char labelString[10];

    prevvalid = currentClip->prev != NULL;
    nextvalid = currentClip->next != NULL;
    XtSetArg (arg, XtNsensitive, prevvalid);
    XtSetValues (prevButton, &arg, ONE);
    XtSetArg (arg, XtNsensitive, nextvalid);
    XtSetValues (nextButton, &arg, ONE);
    sprintf (labelString, "%d", IndexCurrentClip ());
    XtSetArg (arg, XtNlabel, labelString);
    XtSetValues (indexLabel, &arg, ONE);
}

/* ARGSUSED */
static void
NextCurrentClip(Widget w, XEvent *ev, String *parms, Cardinal *np)
{
    if (currentClip->next)
    {
		//SaveClip (text, currentClip);
		currentClip = currentClip->next;
		RestoreClip (text, currentClip);
		set_button_state ();
    }
}

/* ARGSUSED */
static void
PrevCurrentClip(Widget w, XEvent *ev, String *parms, Cardinal *np)
{
    if (currentClip->prev)
    {
		//SaveClip (text, currentClip);
		currentClip = currentClip->prev;
		RestoreClip (text, currentClip);
		set_button_state ();
    }
}

/* ARGSUSED */
static void
DeleteCurrentClip(Widget w, XEvent *ev, String *parms, Cardinal *np)
{
    ClipPtr newCurrent;

    if (currentClip->prev)
		newCurrent = currentClip->prev;
    else
		newCurrent = currentClip->next;
    if (newCurrent)
    {
		DeleteClip (text, currentClip);
		currentClip = newCurrent;
		RestoreClip (text, currentClip);
    }
    else
		EraseTextWidget ();

    set_button_state ();
}

/* ARGSUSED */
static void
Quit(Widget w, XEvent *ev, String *parms, Cardinal *np)
{
    XtCloseDisplay  (XtDisplay (text));
    DisplayClipInfo();
    exit (0);
}

static void
CenterWidgetAtPoint(Widget w, int x, int y)
{
    Arg	args[2];
    Dimension	width, height;

    XtSetArg(args[0], XtNwidth, &width);
    XtSetArg(args[1], XtNheight, &height);
    XtGetValues (w, args, 2);
    x = x - (int) width / 2;
    y = y - (int) height / 2;
    if (x < 0)
		x = 0;
    else {
		int scr_width = WidthOfScreen (XtScreen(w));
		if (x + (int)width > scr_width)
		    x = scr_width - width;
    }

    if (y < 0)
		y = 0;
    else {
		int scr_height = HeightOfScreen (XtScreen(w));
		if (y + (int)height > scr_height)
		    y = scr_height - height;
    }

    XtSetArg(args[0], XtNx, x);
    XtSetArg(args[1], XtNy, y);
    XtSetValues (w, args, 2);
}

static void
CenterWidgetOnEvent(Widget w, XEvent *e)
{
    CenterWidgetAtPoint (w, e->xbutton.x_root, e->xbutton.y_root);
}

static void
CenterWidgetOnWidget(Widget w, Widget wT)
{
    Position	rootX, rootY;
    Dimension	width, height;
    Arg		args[2];

    XtSetArg (args[0], XtNwidth, &width);
    XtSetArg (args[1], XtNheight, &height);
    XtGetValues (wT, args, 2);
    XtTranslateCoords (wT, (Position) width/2, (Position) height/2, &rootX, &rootY);
    CenterWidgetAtPoint (w, (int) rootX, (int) rootY);
}

/*ARGSUSED*/
static void
SaveToFile(Widget w, XEvent *e, String *argv, Cardinal *argc)
{
    Arg	    args[1];
    char    *filename;

    filename = "clipboard";
    if (currentClip->filename)
	filename = currentClip->filename;
    XtSetArg(args[0], XtNvalue, filename);
    XtSetValues (fileDialog, args, 1);
    CenterWidgetOnEvent (fileDialogShell, e);
    XtPopup (fileDialogShell, XtGrabNone);
}

/*ARGSUSED*/
static void
AcceptSaveFile(Widget w, XEvent *e, String *argv, Cardinal *argc)
{
    char    *filename;
    Boolean success;
    Arg	    args[1];

    filename = XawDialogGetValueString (fileDialog);
    success = XawAsciiSaveAsFile (XawTextGetSource (text), filename);
    XtPopdown (fileDialogShell);
    if (!success)
    {
	char	failMessage[1024];

	sprintf (failMessage, "Can't open file \"%s\"", filename);
	XtSetArg (args[0], XtNlabel, failMessage);
	XtSetValues (failDialog, args, 1);
	CenterWidgetOnEvent (failDialogShell, e);
	XtPopup (failDialogShell, XtGrabNone);
    }
    else
    {
	if (currentClip->filename)
	    free (currentClip->filename);
	currentClip->filename = malloc (strlen (filename) + 1);
	if (currentClip->filename)
	    strcpy (currentClip->filename, filename);
    }
}

/* ARGSUSED */
static void
CancelSaveFile(Widget w, XEvent *ev, String *parms, Cardinal *np)
{
    XtPopdown (fileDialogShell);
}

/* ARGSUSED */
static void
FailContinue(Widget w, XEvent *ev, String *parms, Cardinal *np)
{
    XtPopdown (failDialogShell);
}

/*ARGSUSED*/
static void 
WMProtocols(Widget w, XEvent *ev, String *params, Cardinal *n)
{
    if (ev->type == ClientMessage &&
	ev->xclient.message_type == wm_protocols &&
	ev->xclient.data.l[0] == (long) wm_delete_window) {
	while (w && !XtIsShell(w))
	    w = XtParent(w);
	if (w == top)
	    Quit(w, ev, params, n);
	else if (w == fileDialogShell)
	    CancelSaveFile(w, ev, params, n);
	else if (w == failDialogShell)
	    FailContinue(w, ev, params, n);
    }
}

/* ARGUSED */
static void
NewCurrentClip(Widget w, XEvent *ev, String *parms, Cardinal *np)
{
    /*NewCurrentClipContents ("", 0,-1,NULL,0,-1,NULL);*/
}

static void
NewCurrentClipContents(char *data, int len, Window window, char **win_info_list, int win_info_length, Window supportWindow, char * supportWindowName )
{
    XawTextBlock textBlock;

    //SaveClip (text, currentClip);

    /* append new clips at the end */
    while (currentClip && currentClip->next)
		currentClip = currentClip->next;

	ClipPtr temp;
	temp = currentClip;
	if(currentClip != NULL) {
		if(currentClip->requestors == NULL) {
			currentClip = currentClip->prev;
			free(temp);
		}
	}
	temp = NULL;

    /* any trailing clips with no text get overwritten */
    //if (strlen (currentClip->clip) != 0)
		currentClip = NewClip (text, currentClip, data, window, win_info_list, win_info_length, supportWindow, supportWindowName);
    	textBlock.ptr = data;
    	textBlock.firstPos = 0;
    	textBlock.length = len;
    textBlock.format = FMT8BIT;
    if (XawTextReplace(text, 0, TextLength (text), &textBlock)) {
#ifdef XKB
	XkbStdBell(XtDisplay(text), XtWindow(text), 0, XkbBI_Info);
#else
	XBell( XtDisplay(text), 0);
#endif
    }
    set_button_state ();
}

static void
EraseTextWidget(void)
{
    XawTextBlock block;

    block.ptr = "";
    block.length = 0;
    block.firstPos = 0;
    block.format = FMT8BIT;

    XawTextReplace(text, 0, INFINITY, &block);
    /* If this fails, too bad. */
}


static XtActionsRec xclipboard_actions[] = {
    { "NewClip", 	NewCurrentClip }, 
    { "NextClip",	NextCurrentClip },
    { "PrevClip",	PrevCurrentClip },
    { "DeleteClip",	DeleteCurrentClip },
    { "Save",		SaveToFile },
    { "AcceptSave",	AcceptSaveFile },
    { "CancelSave",	CancelSaveFile },
    { "FailContinue",	FailContinue },
    { "Quit",		Quit },
    { "WMProtocols",	WMProtocols }
};

static XrmOptionDescRec table[] = {
    {"-w",	    "wrap",		XrmoptionNoArg,  "on"},
/*    {"-nw",	    "wrap",		XrmoptionNoArg,  "False"} */
};

static Boolean ConvertSelection ( Widget w, Atom *selection, Atom *target, 
				  Atom *type, XtPointer *value, 
				  unsigned long *length, int *format );
static void LoseSelection ( Widget w, Atom *selection );

static Atom	ManagerAtom, ClipboardAtom;

/*ARGSUSED*/
int GetWindowInfo(Display *d, Window window, char ***win_info_list_ptr, int *win_info_length_ptr) {
	int retval;
#ifdef NO_I18N
	char *win_name;
	retval = XFetchName(d,window,&win_name);
	if(!retval) {
		*win_info_list_ptr = (char **)malloc(sizeof(char **));
		**win_info_list_ptr = (char *)malloc(15);
		strcpy(**win_info_list_ptr, "(has no name)");
		*win_info_length_ptr = 1;
	} else if(win_name) {
		*win_info_list_ptr = (char **)malloc(sizeof(char **));
		**win_info_list_ptr = win_name;
		*win_info_length_ptr = 1;
	}
#else
	XTextProperty win_info;
	XGetWMName(d,window,&win_info);
	retval = XmbTextPropertyToTextList(d,&win_info,win_info_list_ptr,win_info_length_ptr);
	int i;
	if (retval == Success || retval > 0 && *win_info_list_ptr != NULL) {
	
	} else {
		*win_info_list_ptr = (char **)malloc(sizeof(char **));
		*win_info_list_ptr = win_info.value;
		*win_info_length_ptr = 1;
	}
#endif
	return retval;
}

static void 
InsertClipboard(Widget w, XtPointer client_data, Atom *selection, 
		Atom *type, XtPointer value, unsigned long *length, 
		int *format)
{
 	Display *d = XtDisplay(w);
    Atom target = (Atom)client_data;
    Boolean convert_failed = (*type == XT_CONVERT_FAIL);

    if (!convert_failed)
    {
	char **list;
	int i, ret, count;

	XTextProperty prop;
	prop.value = value;
	prop.nitems = *length;
	prop.format = *format;
	prop.encoding = *type;
	ret = XmbTextPropertyToTextList(d, &prop, &list, &count);
	if (ret >= Success)
	{
		Window supportWindow = XGetSelectionOwner(d,*selection);
		char **supportWindowName;
		int supportWindowNameLenght;
		Window window;
		char **win_info_list;
		int win_info_length;
		//contingency checking
		//xdotool gives the information about the GUI activity.
		FILE *fp = popen("xdotool getactivewindow","r");
		int test;
		fscanf(fp,"%d",&test);
		window=test;
		fclose(fp);
		//---------------------------
		GetWindowInfo(d,window,&win_info_list,&win_info_length);
		GetWindowInfo(d, supportWindow, &supportWindowName, &supportWindowNameLenght);
	/* manuals say something about multiple strings in a disjoint
	    text selection (?), it should be harmless to get them all */
	    for (i = 0; i < count; i++) {
			NewCurrentClipContents(list[i], strlen(list[i]),window,win_info_list,win_info_length, supportWindow, *supportWindowName);
		}
	    XFreeStringList(list);
	} else
	    convert_failed = True;
	XFree(value);
    }

    if (convert_failed) {
	/* if UTF8_STRING failed try COMPOUND_TEXT */
	if (target == XA_UTF8_STRING(d))
	{
	    XtGetSelectionValue(w, *selection, XA_COMPOUND_TEXT(d),
				InsertClipboard,
				(XtPointer)(XA_COMPOUND_TEXT(d)),
				CurrentTime);
	    return;
	}
	/* if COMPOUND_TEXT failed try STRING */
	else if (target == XA_COMPOUND_TEXT(d))
	{
	    XtGetSelectionValue(w, *selection, XA_STRING,
				InsertClipboard,
				NULL,
				CurrentTime);
	    return;
	}
	/* all conversions failed */
	else
	{
	    Arg arg;
	    XtSetArg (arg, XtNlabel, "CLIPBOARD selection conversion failed");
	    XtSetValues (failDialog, &arg, 1);
	    CenterWidgetOnWidget (failDialogShell, text);
	    XtPopup (failDialogShell, XtGrabNone);
#ifdef XKB
	    XkbStdBell (d, XtWindow(w), 0, XkbBI_MinorError);
#else
	    XBell (d, 0);
#endif
	}
    }
    
    XtOwnSelection(top, ClipboardAtom, CurrentTime,
		   ConvertSelection, LoseSelection, NULL);
}

static Boolean 
ConvertSelection(Widget w, Atom *selection, Atom *target,
		 Atom *type, XtPointer *value, unsigned long *length, 
		 int *format)
{
    Display* d = XtDisplay(w);
    XSelectionRequestEvent* req =
	XtGetSelectionRequest(w, *selection, (XtRequestId)NULL);
    
    //getting information from requestor window id
    Window requestor_supportWindow = req->requestor, requestor;
	char **supportWindowName;
	int supportWindowNameLength;
	GetWindowInfo(d, requestor_supportWindow, &supportWindowName, &supportWindowNameLength);
	FILE * fp = popen("xdotool getactivewindow","r");
	int test;
    fscanf(fp,"%d",&test);
    requestor=test;
    fclose(fp);
    char **win_info_list;
    int win_info_length;
    GetWindowInfo(d, requestor, &win_info_list, &win_info_length);
    if( *selection == ClipboardAtom ) {
		if(*target != XA_TARGETS(d)) {
			char *target_string;
			if ( *target == XA_LIST_LENGTH(d))
				target_string="XA_LIST_LENGTH";
			if ( *target == XA_LENGTH(d))
				target_string="XA_LENGTH";
			if ( *target == XA_CHARACTER_POSITION(d))
				target_string="XA_CHARACTER_POSITION";
			if ( *target == XA_STRING )
				target_string="XA_STRING";
			if ( *target == XA_TEXT(d))
				target_string="XA_TEXT";
			if ( *target == XA_UTF8_STRING(d))
				target_string="XA_UTF8_STRING";
			if ( *target == XA_COMPOUND_TEXT(d))
				target_string="XA_COMPOUND_TEXT";
			addRequestor(currentClip, requestor, *win_info_list, requestor_supportWindow, *supportWindowName, target_string);
		}
    }

    if (*target == XA_TARGETS(d)) {
	Atom* targetP;
	Atom* std_targets;
	unsigned long std_length;
	XmuConvertStandardSelection(w, req->time, selection, target, type,
				    (XPointer*)&std_targets, &std_length,
				    format);
	*value = XtMalloc(sizeof(Atom)*(std_length + 7));
	targetP = *(Atom**)value;
	*targetP++ = XA_STRING;
	*targetP++ = XA_TEXT(d);
	*targetP++ = XA_UTF8_STRING(d);
	*targetP++ = XA_COMPOUND_TEXT(d);
	*targetP++ = XA_LENGTH(d);
	*targetP++ = XA_LIST_LENGTH(d);
	*targetP++ = XA_CHARACTER_POSITION(d);
	*length = std_length + (targetP - (*(Atom **) value));
	memmove( (char*)targetP, (char*)std_targets, sizeof(Atom)*std_length);
	XtFree((char*)std_targets);
	*type = XA_ATOM;
	*format = 32;
	return True;
    }

    if (*target == XA_LIST_LENGTH(d) ||
	*target == XA_LENGTH(d))
    {
    	long * temp;
    	
    	temp = (long *) XtMalloc(sizeof(long));
    	if (*target == XA_LIST_LENGTH(d))
      	  *temp = 1L;
    	else			/* *target == XA_LENGTH(d) */
      	  *temp = (long) TextLength (text);
    	
    	*value = (XPointer) temp;
    	*type = XA_INTEGER;
    	*length = 1L;
    	*format = 32;
    	return True;
    }
    
    if (*target == XA_CHARACTER_POSITION(d))
    {
    	long * temp;
    	
    	temp = (long *) XtMalloc(2 * sizeof(long));
    	temp[0] = (long) 0;
    	temp[1] = TextLength (text);
    	*value = (XPointer) temp;
    	*type = XA_SPAN(d);
    	*length = 2L;
    	*format = 32;
    	return True;
    }
    
    if (*target == XA_STRING ||
	*target == XA_TEXT(d) ||
	*target == XA_UTF8_STRING(d) ||
	*target == XA_COMPOUND_TEXT(d))
    {
	Arg args[1];
	Widget source;
	XTextProperty prop;
	int ret, style = XStdICCTextStyle; /* a safe default for TEXT */
	char *data;

	source = XawTextGetSource (text);
	XtSetArg (args[0], XtNstring, &data);
	XtGetValues (source, args, 1);

	if (*target == XA_UTF8_STRING(d))
	    style = XUTF8StringStyle;
	else if (*target == XA_COMPOUND_TEXT(d))
	    style = XCompoundTextStyle;
	else if (*target == XA_STRING)
	    style = XStringStyle;

	ret = XmbTextListToTextProperty (d, &data, 1, style, &prop);
	if (ret >= Success) {
	    *length = prop.nitems;
	    *value = prop.value;
	    *type = prop.encoding;
	    *format = prop.format;
	    return True;
	} else
	    return False;
    }

    if (XmuConvertStandardSelection(w, req->time, selection, target, type,
				    (XPointer *) value, length, format))
	return True;

    return False;
}

static void 
LoseSelection(Widget w, Atom *selection)
{
    Display *d = XtDisplay(w);
    XtGetSelectionValue(w, *selection, XA_UTF8_STRING(d), InsertClipboard,
			(XtPointer)(XA_UTF8_STRING(d)), CurrentTime);
}

/*ARGSUSED*/
static Boolean 
RefuseSelection(Widget w, Atom *selection, Atom *target,
		Atom *type, XtPointer *value, unsigned long *length, 
		int *format)
{
    return False;
}

/*ARGSUSED*/
static void 
LoseManager(Widget w, Atom *selection)
{
    XtError("another clipboard has taken over control\n");
}

typedef struct {
  Boolean wrap;
} ResourceData, *ResourceDataPtr;

static ResourceData userOptions;

#define Offset(field) XtOffsetOf(ResourceData, field)

static XtResource resources[] = {
  {"wrap", "Wrap", XtRBoolean, sizeof(Boolean),
     Offset(wrap), XtRImmediate, (XtPointer)False}
};

#undef Offset

void DisplayClipInfo () {
	ClipPtr q;
    if((currentClip == NULL) || (currentClip->window == 0)) {
         printf("Empty Clipboard");
    } else {
			printf("Have Clipboard");
        	for(q = currentClip; q != NULL; q = q->prev) {
					printf("\nstart\n");
					printf("\n+++++++++++++");
                	printf("\nWindow ID:0x%x, Window Name: %s",q->window,q->win_info_list[0]);
					printf("\nSupport Window ID: 0x%x, Support Window Name: %s", q->supportWindow, q->supportWindowName);
					printf("\nContent----------------------------------\n%s\n----------------------------------",q->clip);
                	//printf("Window ID:0x%x\n:",q->window);
					RequestorPtr r = q->requestors;
					while(r != NULL) {
						printf("\nRequestor Window ID: 0x%x, Requestor Name: %s, Target: %s", r->window, r->name, r->target_string);
						printf("\nSupport Window ID: 0x%x, Support Window Name: %s", r->supportWindow, r->supportWindowName);
						r = r->next;
					}
					printf("\n+++++++++++++\n");
					printf("\nend\n");
			}
	}
	printf("LOL\n");
}

int
main(int argc, char *argv[])
{
    Arg args[4];
    Cardinal n;
    XtAppContext xtcontext;
    Widget parent;

    XtSetLanguageProc(NULL, NULL, NULL);

    top = XtAppInitialize( &xtcontext, "XClipboard", table, XtNumber(table),
			  &argc, argv, fallback_resources, NULL, 0);

    XtGetApplicationResources(top, (XtPointer)&userOptions, resources, 
			      XtNumber(resources), NULL, 0);

    XtAppAddActions (xtcontext,
		     xclipboard_actions, XtNumber (xclipboard_actions));
    /* CLIPBOARD_MANAGER is a non-standard mechanism */
    ManagerAtom = XInternAtom(XtDisplay(top), "CLIPBOARD_MANAGER", False);
    ClipboardAtom = XA_CLIPBOARD(XtDisplay(top));
    if (XGetSelectionOwner(XtDisplay(top), ManagerAtom))
	XtError("another clipboard is already running\n");

    parent = XtCreateManagedWidget("form", formWidgetClass, top, NULL, ZERO);
    (void) XtCreateManagedWidget("quit", Command, parent, NULL, ZERO);
    (void) XtCreateManagedWidget("delete", Command, parent, NULL, ZERO);
    (void) XtCreateManagedWidget("new", Command, parent, NULL, ZERO);
    (void) XtCreateManagedWidget("save", Command, parent, NULL, ZERO);
    nextButton = XtCreateManagedWidget("next", Command, parent, NULL, ZERO);
    prevButton = XtCreateManagedWidget("prev", Command, parent, NULL, ZERO);
    indexLabel = XtCreateManagedWidget("index", Label, parent, NULL, ZERO);
	
    n=0;
    XtSetArg(args[n], XtNtype, XawAsciiString); n++;
    XtSetArg(args[n], XtNeditType, XawtextEdit); n++;
    if (userOptions.wrap) {
	XtSetArg(args[n], XtNwrap, XawtextWrapWord); n++;
	XtSetArg(args[n], XtNscrollHorizontal, False); n++;
    }

    text = XtCreateManagedWidget( "text", Text, parent, args, n);
    
    currentClip = NewClip (text, NULL,"Initial Clip",0,NULL,-1,0,NULL);

    //set_button_state ();

    fileDialogShell = XtCreatePopupShell("fileDialogShell",
					 transientShellWidgetClass,
					 top, NULL, ZERO);
    fileDialog = XtCreateManagedWidget ("fileDialog", dialogWidgetClass,
					fileDialogShell, NULL, ZERO);
    XawDialogAddButton(fileDialog, "accept", NULL, NULL);
    XawDialogAddButton(fileDialog, "cancel", NULL, NULL);

    failDialogShell = XtCreatePopupShell("failDialogShell",
					 transientShellWidgetClass,
					 top, NULL, ZERO);
    failDialog = XtCreateManagedWidget ("failDialog", dialogWidgetClass,
					failDialogShell, NULL, ZERO);
    XawDialogAddButton (failDialog, "continue", NULL, NULL);

    XtRealizeWidget(top);
    XtRealizeWidget(fileDialogShell);
    XtRealizeWidget(failDialogShell);
    XtOwnSelection(top, ManagerAtom, CurrentTime,
		   RefuseSelection, LoseManager, NULL);
    if (XGetSelectionOwner (XtDisplay(top), ClipboardAtom)) {
	LoseSelection (top, &ClipboardAtom);
    } else {
    	XtOwnSelection(top, ClipboardAtom, CurrentTime,
		       ConvertSelection, LoseSelection, NULL);
    }
    wm_delete_window = XInternAtom(XtDisplay(top), "WM_DELETE_WINDOW", False);
    wm_protocols = XInternAtom(XtDisplay(top), "WM_PROTOCOLS", False);
    (void) XSetWMProtocols(XtDisplay(top), XtWindow(top), &wm_delete_window,1);
    (void) XSetWMProtocols(XtDisplay(top), XtWindow(fileDialogShell),
			   &wm_delete_window,1);
    (void) XSetWMProtocols(XtDisplay(top), XtWindow(failDialogShell),
			   &wm_delete_window,1);
    	//printf("This is an error");
	XtAppMainLoop(xtcontext);
    exit(0);
}
