variable "lz_vending" {
  type = map(object({
    location = string
    name     = string
    alias    = string
  }))
}
