

class SignUpWithEmailAndPasswordFailure{
  final String message;

  const SignUpWithEmailAndPasswordFailure([this.message="Une erreur inconnue est survenue"]);

  factory SignUpWithEmailAndPasswordFailure.code(String code){
    switch(code){
      case 'mot de passe faible':
      return const SignUpWithEmailAndPasswordFailure('veuillez entrer un mot de passe fort');
      case 'email-invalide':
      return const SignUpWithEmailAndPasswordFailure('Email invalide');
      case 'Email déjà utilisé':
      return const SignUpWithEmailAndPasswordFailure('un compte existe déjà pour cet e-mail');
      case 'utilisateur désactivé':
      return const SignUpWithEmailAndPasswordFailure("cet utilisateur a été désactivé, veuillez contacter le support pour obtenir de l'aide");
      default:
      return const SignUpWithEmailAndPasswordFailure();
    }
  }


}