library core;

// Style
export 'styles/colors.dart';
export 'styles/text_styles.dart';

// Bloc
export 'presentation/bloc/auth/auth_bloc.dart';
export 'presentation/bloc/page/set_page_bloc.dart';
export 'presentation/bloc/onboarding/onboarding_bloc.dart';

// Pages
export 'presentation/pages/login_page.dart';
export 'presentation/pages/register_page.dart';
export 'presentation/pages/home_page.dart';
export 'presentation/pages/login_page.dart';
export 'presentation/pages/register_page.dart';
export 'presentation/pages/home_page.dart';
export 'presentation/pages/main_page.dart';
export 'presentation/pages/detail_income_page.dart';
export 'presentation/pages/detail_expense_page.dart';
export 'presentation/pages/add_income_page.dart';
export 'presentation/pages/set_balance_page.dart';

// Data
export 'data/repository/auth_repository_impl.dart';
export 'data/models/user_model.dart';

// Domain
export 'domain/repository/auth_repository.dart';
export 'domain/usecases/auth/register.dart';
export 'domain/usecases/auth/logout.dart';
export 'domain/usecases/auth/login_google.dart';
export 'domain/usecases/auth/login.dart';
export 'domain/repository/database_repository.dart';

// Widgets
export 'presentation/widgets/divider_custom.dart';
export 'presentation/widgets/title_page.dart';
export 'presentation/widgets/textform_email.dart';
export 'presentation/widgets/textform_password.dart';
export 'presentation/widgets/checkbox_custom.dart';
export 'presentation/widgets/login_question.dart';

// Common
export 'utils/failure.dart';
export 'common/route_observer.dart';
