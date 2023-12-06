import 'package:dmiti_project/res/theme.dart';
import 'package:flutter/material.dart';

class MainInfo extends StatelessWidget {
  const MainInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                child: Text("Основная информация по использованию программы:\n",
                    style: getTheme().textTheme.bodyLarge),
              ),
            ),
            Text("Приложение NAME содержит 4 раздела:\n",
                style: getTheme().textTheme.bodyLarge),
            Text(
                "Обучение (эта вкладка) - в ней находится информация о приложении, инструкция по вводу решения\n",
                style: getTheme().textTheme.bodyLarge),
            Text(
                "Практика - в этом разделе Вы можете практиковаться в решении задач с возможностью пользоваться подсказками\n",
                style: getTheme().textTheme.bodyLarge),
            Text(
                "Тестирование -  В этом разделе необходимо решить 8 задач для самоконтроля, после решения выводится результат\n",
                style: getTheme().textTheme.bodyLarge),
            Text("Профиль - доступ к личной статистике и настройкам\n",
                style: getTheme().textTheme.bodyLarge),
            Text("Общие вопросы:", style: getTheme().textTheme.bodyLarge),
            Text(
                "Как решать задачи: В большинстве задач используется алгоритм Евклида, ссылка на методический материал (тык), либо следующие алгоритмы(тык)\n",
                style: getTheme().textTheme.bodyLarge),
            Text(
                "Как вводить ответ: В выпадающем окне Вы можете перейти в раздел с соответствующей задачей и посмотреть верный пример ввода. По окончании ввода нажать кнопку \"отправить\" и проверить корректность решения\n",
                style: getTheme().textTheme.bodyLarge),
            Text(
                "Как проходит режим тестирования: Задачи отображаются одна за другой, переход к следующей происходит после решения предыдущей. В конце выводится количество верно решенных задач, при нажати на кнопку \"назад\" происходит возврат к нерешенной задаче. При верном решении всех задач выводится соответствующее сообщение. При выходе из режима тестирования прогресс не сохраняется!\n",
                style: getTheme().textTheme.bodyLarge)
          ],
        ),
      ),
    );
  }
}
