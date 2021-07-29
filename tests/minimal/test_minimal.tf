terraform {
  required_providers {
    test = {
      source = "terraform.io/builtin/test"
    }

    aci = {
      source  = "netascode/aci"
      version = ">=0.2.0"
    }
  }
}

module "main" {
  source = "../.."
}

data "aci_rest" "aaaPreLoginBanner" {
  dn = "uni/userext/preloginbanner"

  depends_on = [module.main]
}

resource "test_assertions" "aaaPreLoginBanner" {
  component = "aaaPreLoginBanner"

  equal "guiMessage" {
    description = "guiMessage"
    got         = data.aci_rest.aaaPreLoginBanner.content.guiMessage
    want        = ""
  }

  equal "guiTextMessage" {
    description = "guiTextMessage"
    got         = data.aci_rest.aaaPreLoginBanner.content.guiTextMessage
    want        = ""
  }

  equal "message" {
    description = "message"
    got         = data.aci_rest.aaaPreLoginBanner.content.message
    want        = ""
  }

  equal "switchMessage" {
    description = "switchMessage"
    got         = data.aci_rest.aaaPreLoginBanner.content.switchMessage
    want        = ""
  }
}
