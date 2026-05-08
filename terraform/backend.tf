terraform {
  backend "s3" {
    bucket = "jpbarto-awsvpoc-us-east-1-harness-tf-state"
    key    = "psm-jpbarto/guestbook/state"
    region = "us-east-1"
  }
}
