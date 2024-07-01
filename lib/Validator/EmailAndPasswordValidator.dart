class Validator{
    EmailValidation() {
    return (value) {
      if (value!.isEmpty) {
        return "Email cannot be empty";
      }
      if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
        return ("Please enter a valid mail ID");
      }
      if (!value!.contains("@citchennai.net")) {
        return ("Please enter college mail ID");
      } else {
        return null;
      }
    };
  }

  PasswordValidation() {
    return (value) {
      if (value!.isEmpty) {
        return "Password cannot be empty";
      }
      if (!RegExp(r'^.{6,}$').hasMatch(value)) {
        return ("please enter minmium 6 character");
      } else {
        return null;
      }
    };
  }
}