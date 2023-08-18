import 'package:get/get_navigation/src/root/internacionalization.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'fa_IR': {
          'greeting': 'سلام👋',
          'enter_code': 'لطفا شناسه‌ای که برات ایمیل شده‌ارو اینجا وارد کن.',
          'wrong_id': 'شناسه اشتباه است.',
          'accept': 'تایید',
          'choose_language': 'زبان مورد نظر خود را انتخاب کنید',
          'id': 'شناسه',
          'greeting_name': 'سلام، @name 👋',
          'explanation': 'توضیح',
          'example': 'مثال',
          'exercise': 'تمرین',
          'exercise_solution': 'جواب تمرین',
          'exercise_solution_prompt': 'جواب این تمرین را به من بده',
          'choose_lesson': 'اولین درس خود را انتخاب کنید!',
          'logout': 'خروج',
        },
        'en_US': {
          'greeting': 'Hello👋',
          'enter_code': 'Please enter the code emailed to you earlier',
          'wrong_id': 'ID is wrong',
          'accept': 'Enter',
          'choose_language': 'Choose your preferred language',
          'id': 'id',
          'greeting_name': 'Hi, @name 👋',
          'explanation': 'Explanation',
          'example': 'Example',
          'exercise': 'Exercise',
          'exercise_solution': 'Exercise Solution',
          'exercise_solution_prompt':
              'Give me the solution to the last exercise',
          'choose_lesson': 'Choose your very first lesson!',
          'logout': 'logout',
        },
      };
}
