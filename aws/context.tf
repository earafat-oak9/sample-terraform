variable "context" {
  type = object({
    my_name             = string
    profile             = string
    delimiter           = string
    tags                = map(string)
  })

  default = {
    # Set these:
    my_name             = "eyad"
    profile             = "sandbox-rw"

    tags                = { }
    delimiter           = "_"
  }
}
