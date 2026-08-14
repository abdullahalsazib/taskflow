#ifndef FLUTTER_task_flowLICATION_H_
#define FLUTTER_task_flowLICATION_H_

#include <gtk/gtk.h>

G_DECLARE_FINAL_TYPE(MyApplication,
                     task_flowlication,
                     MY,
                     APPLICATION,
                     GtkApplication)

/**
 * task_flowlication_new:
 *
 * Creates a new Flutter-based application.
 *
 * Returns: a new #MyApplication.
 */
MyApplication* task_flowlication_new();

#endif  // FLUTTER_task_flowLICATION_H_
