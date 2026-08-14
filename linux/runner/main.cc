#include "task_flowlication.h"

int main(int argc, char** argv) {
  g_autoptr(MyApplication) app = task_flowlication_new();
  return g_application_run(G_APPLICATION(app), argc, argv);
}
