resource "aws_iam_user" "think_user" {
  name = "testing_user"
}
resource "aws_iam_access_key" "think_user_access_key" {
    user = "${aws_iam_user.think_user.name}"
    pgp_key = "keybase:testing_user"
}


output "access_key" {
    value = ${aws_iam_access_key.think_user_access_key.id}"
}
output "secret" {
    value = "${aws_iam_access_key.think_user_access_key.encrypted_secret}"
}