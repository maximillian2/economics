require 'tty'

# Setup
shell = TTY::Shell.new
input_table = TTY::Table.new(header: ['Вхідні дані', 'Введене число'])
output_table = TTY::Table.new(header: ['Результати', 'Скорочення', 'Відповідь'])

## Greeting
shell.say('Практична робота №1')
shell.say('Розрахунок показників ефективності випуску та використання акцій підприємства')
shell.warn('Введіть потрібні дані:')

## Input
AKb = shell.ask('Балансова вартість акціонернего капіталу (АКб) (в тис.): ').argument(:required).read_float * 1000.0
P = shell.ask('Розмір страхового (резервного) фонду (Р) (в тис.): ').argument(:required).read_float * 1000.0
K = shell.ask('Кількість емітованих акцій (К) (в тис.): ').argument(:required).read_float * 1000.0
percentAp = shell.ask('Ринкова вартість одної акції (Ар) (%): ').argument(:required).read_float / 100.0
Pch = shell.ask('Чистий прибуток підприємства (Пч) (в тис.): ').argument(:required).read_float * 1000.0
PK = shell.ask('Позикові кошти (ПК) (в тис.): ').argument(:required).read_float * 1000.0
percentPK = shell.ask('Відсоток річних, під які були залучені позикові кошти (% за ПК): ').argument(:required).read_float / 100.0
procentFn = shell.ask('Фонд нагромадження (Фн) (%): ').argument(:required).read_float / 100.0
Vprop = shell.ask('Пропозиція на продаж акцій на суму (V проп) (в тис.): ').argument(:required).read_float * 1000.0
Vprod = shell.ask('Реально проданих акцій на суму (V прод) (в тис.): ').argument(:required).read_float * 1000.0

## Input table
system('clear')
input_table << ['АКб', AKb] << ['P', P]
input_table << ['K', K] << ['Ар', percentAp]
input_table << ['Пч', Pch] << ['ПК', PK]
input_table << ['% за ПК', percentPK] << ['% Фн', procentFn]
input_table << ['V проп', Vprop] << ['V прод', Vprod]
puts input_table.render(:unicode)

## Calculations

## Балансова вартість однієї акції
Ab = (AKb + P) / K
## Ринкова вартість однієї акції
Ap = Ab * percentAp
## Капіталізована вартість акцій
sigmaAp = Ap * K
## Співвідношення ринкової і балансової вартості акцій
Ca = (Ab * percentAp) / Ab
## абсолютна сума відсотків за користування позиковими коштами
Vpk = PK * percentPK
## Прибуток на акцію
Pa = (Pch - Vpk)/ K
## Фонд нагромадження
Fn = (Pch - Vpk) * procentFn
## Дивіденд на акцію
d = (Pch - Vpk - Fn) / K
## Дивідентна віддача акцій
Da = d / Ap
## Сукупний дохід акціонера
SD = (Ap - Ab) + d
## Коефіцієнт ліквідності акцій
Kl = Vprop / Vprod
## Коефіцієнт обігу акцій
Kob = Vprod / sigmaAp

## Rendering
output_table << ['Балансова вартість однієї акції', 'Аб', '%.1f' % Ab]
output_table << ['Капіталізована вартість акцій', "\u03A3Ар", '%.2f' % sigmaAp]
output_table << ['Співвідношення ринкової і балансової вартості акцій', 'Са',  '%.2f' % Ca]
output_table << ['Прибуток на акцію', 'Па', '%.3f' % Pa]
output_table << ['Дивіденд на акцію', 'd',  '%.2f' % d]
output_table << ['Дивідентна віддача акцій', 'Да', '%.2f' % Da]
output_table << ['Сукупний дохід акціонера', 'СД', '%.2f' % SD]
output_table << ['Коефіцієнт ліквідності акцій', 'Кл', '%.2f' % Kl]
output_table << ['Коефіцієнт обігу акцій', 'Коб', '%.2f' % Kob]
puts output_table.render(:unicode, width: 90, resize: true)
