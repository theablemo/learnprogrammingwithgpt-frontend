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
          'example_id':
              '(یا می‌توانید برای امتحان کردن برنامه، کد 0000 را وارد کنید.)',
          'this_may_take_a_while':
              'به دلیل کند بودن API OpenAI، این عملیات ممکن است کمی طول بکشد. لطفا صبر کنید...',
          'about': 'درباره',
          'about_content':
              'این پلتفرم در ابتدا برای مقاله \'Leveraging ChatGPT for Adaptive Learning through Personalized Prompt-based Instruction: A CS1 Education Case Study\' ساخته شده است. این مقاله در حال بررسی است و پس از آن نام سازندگان منتشر خواهد شد.',
          'cool': 'عالیه!'
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
          'example_id':
              '(Or to try out the application, you can enter code 0000.)',
          'this_may_take_a_while':
              '(Because of OpenAI\'s API, this operation may take a while. Please wait...)',
          'about': 'About',
          'about_content':
              'This platform was initially made for the paper \'Leveraging ChatGPT for Adaptive Learning through Personalized Prompt-based Instruction: A CS1 Education Case Study\'. The paper is currently under review, and after that name of the creators will be published.',
          'cool': 'Cool!'
        },
      };
}
