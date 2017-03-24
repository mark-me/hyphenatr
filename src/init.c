#include <R.h>
#include <Rinternals.h>
#include <stdlib.h> // for NULL
#include <R_ext/Rdynload.h>

/* FIXME:
   Check these declarations against the C/Fortran source code.
*/

/* .Call calls */
extern SEXP hyphenatr_cleanup();
extern SEXP hyphenatr_hyphenate(SEXP);
extern SEXP hyphenatr_hyphendict_is_loaded();
extern SEXP hyphenatr_init(SEXP);

static const R_CallMethodDef CallEntries[] = {
    {"hyphenatr_cleanup",              (DL_FUNC) &hyphenatr_cleanup,              0},
    {"hyphenatr_hyphenate",            (DL_FUNC) &hyphenatr_hyphenate,            1},
    {"hyphenatr_hyphendict_is_loaded", (DL_FUNC) &hyphenatr_hyphendict_is_loaded, 0},
    {"hyphenatr_init",                 (DL_FUNC) &hyphenatr_init,                 1},
    {NULL, NULL, 0}
};

void R_init_hyphenatr(DllInfo *dll)
{
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}
