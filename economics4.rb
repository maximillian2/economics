require 'tty'

# Setup
shell = TTY::Shell.new
input_table = TTY::Table.new(header: ['Вхідні дані', 'Введене число'])
output_table = TTY::Table.new(header: ['Результати', 'Скорочення', 'Відповідь'])

## Greeting
shell.say('Практична робота №4')
shell.say('Розрахунок показників ефективності використання основних виробничих фондів на підприємстві')
shell.warn('Введіть потрібні дані:')

## Input
TP = shell.ask('Товарна продукція (ТП) (в тис.): ').argument(:required).read_float * 1000.0
Vof = shell.ask('Середньорічна вартість основних виробничих фондів(В о.ф.) (в тис.): ').argument(:required).read_float * 1000.0
Chpr = shell.ask('Середньоспискова чисельність працюючих на підприємстві (Ч пр.) (в тис.): ').argument(:required).read_int
Qp = shell.ask('Розрахункова кількість одиниць обладнання (Q пр.): ').argument(:required).read_float
Q1 = shell.ask('Кількість обладнання в 1 зміну (Q1): ').argument(:required).read_int
Q2 = shell.ask('Кількість обладнання в 2 зміну (Q2): ').argument(:required).read_int
Q3 = shell.ask('Кількість обладнання в 3 зміну (Q3): ').argument(:required).read_int
Pl = shell.ask('Виробнича площа підприємства (Пл) (м^2): ').argument(:required).read_int

## Input table
system('clear')
input_table << ['ТП', TP] << ['В о.ф.', Vof]
input_table << ['Ч пр.', Chpr] << ['Q пр.', Qp]
input_table << ['Q1', Q1] << ['Q2', Q2]
input_table << ['Q3', Q3] << ['Пл', Pl]
puts input_table.render(:unicode)

## Calculations
# Фондовіддача
Fv = TP / Vof
# Фондомісткість
Fm = Vof / TP
# Фондоозброєність
Fo = (Vof / Chpr).to_i
# Випуск продукції з 1 кв.м. виробничої площі
Vprod = (TP / Pl).to_i
# Ступінь заватаження обладнання
latinn = Qp / Qp.ceil.to_f
# Коефіцієнт змінності роботи обладнання
# Q заг = Q пр
Kzm = (Q1.to_f + Q2.to_f + Q3.to_f) / Qp.ceil

## Rendering
output_table << ['Фондовіддача', 'Ф в', '%.2f' % Fv]
output_table << ['Фондомісткість', 'Ф м', '%.2f' % Fm]
output_table << ['Фондоозброєність', 'Ф о', '%i' % Fo]
output_table << ['Випуск продукції з 1 кв.м. виробничої площі', 'В прод.', '%i' % Vprod]
output_table << ['Ступінь заватаження обладнання', "\u019E", '%.2f = %i%' % [latinn, latinn*100.0] ]
output_table << ['Коефіцієнт змінності роботи обладнання', 'К зм', '%.2f' % Kzm]
puts output_table.render(:unicode, width: 90, resize: true)
