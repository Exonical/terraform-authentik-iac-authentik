resource "authentik_task_schedule" "this" {
  app_model = var.app_model
  model_id  = var.model_id
  crontab   = var.crontab

  paused = var.paused
}
