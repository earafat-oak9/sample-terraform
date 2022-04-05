module "dr4" {
    source = "./dr4"
}
module "g4a" {
    source = "./g4a"
    context = var.context
}

variable "context" {
    type = object({
        my_name   = string
        profile   = string
        delimiter = string
        tags      = map(string)
    })
}
