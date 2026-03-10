locals {
  task_schedules = try(local.tasks.schedules, [])
}

module "authentik_task_schedule" {
  source   = "./modules/terraform-authentik-task-schedule"
  for_each = { for t in local.task_schedules : "${t.app_model}/${t.model_id}" => t if local.modules.authentik_task_schedule == true && var.manage_tasks }

  app_model = each.value.app_model
  model_id  = each.value.model_id
  crontab   = each.value.crontab

  paused = try(each.value.paused, false)
}
