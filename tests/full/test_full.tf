terraform {
  required_providers {
    test = {
      source = "terraform.io/builtin/test"
    }

    aci = {
      source  = "CiscoDevNet/aci"
      version = ">=2.0.0"
    }
  }
}

module "main" {
  source = "../.."

  apic_gui_banner_url = "http://1.1.1.1"
  apic_gui_alias      = "PROD"
  apic_cli_banner     = "My CLI Banner"
  switch_cli_banner   = "My Switch Banner"
}

data "aci_rest_managed" "aaaPreLoginBanner" {
  dn = "uni/userext/preloginbanner"

  depends_on = [module.main]
}

resource "test_assertions" "aaaPreLoginBanner" {
  component = "aaaPreLoginBanner"

  equal "guiMessage" {
    description = "guiMessage"
    got         = data.aci_rest_managed.aaaPreLoginBanner.content.guiMessage
    want        = "http://1.1.1.1"
  }

  equal "guiTextMessage" {
    description = "guiTextMessage"
    got         = data.aci_rest_managed.aaaPreLoginBanner.content.guiTextMessage
    want        = "PROD"
  }

  equal "message" {
    description = "message"
    got         = data.aci_rest_managed.aaaPreLoginBanner.content.message
    want        = "My CLI Banner"
  }

  equal "switchMessage" {
    description = "switchMessage"
    got         = data.aci_rest_managed.aaaPreLoginBanner.content.switchMessage
    want        = "My Switch Banner"
  }
}
