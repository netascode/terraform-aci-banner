resource "aci_rest_managed" "aaaPreLoginBanner" {
  dn         = "uni/userext/preloginbanner"
  class_name = "aaaPreLoginBanner"
  content = {
    guiMessage     = var.apic_gui_banner_url
    guiTextMessage = var.apic_gui_alias
    message        = var.apic_cli_banner
    switchMessage  = var.switch_cli_banner
  }
}
