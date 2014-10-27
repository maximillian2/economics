require 'tty'

# Setup
shell = TTY::Shell.new
input_table = TTY::Table.new(header: ['Вхідні дані', 'Введене число'])
output_table = TTY::Table.new(header: ['Результати', 'Скорочення', 'Відповідь'])

## Greeting
shell.say('Практична робота №6')
shell.say('Розрахунок показників оборотності оборотних коштів підприємства')
shell.warn('Введіть потрібні дані:')

## Input
# Плановий обсяг реалізованої продукції 
PRP = shell.ask('Плановий обсяг реалізованої продукції (ПРП) (в тис.): ').argument(:required).read_int * 1000
# Фактичний обсяг реалізованої продукції 
FRP = shell.ask('Фактичний обсяг реалізованої продукції (ФРП) (в тис.): ' ).argument(:required).read_int * 1000
# Плановий середньорічний залишок нормованих оборотних коштів 
PVobk = shell.ask('Плановий середньорічний залишок нормованих оборотних коштів (П В об. к) (в тис.): ').argument(:required).read_int * 1000
# Фактичний середньорічний залишок нормованих оборотних коштів  
FVobk = shell.ask('Фактичний середньорічний залишок нормованих оборотних коштів (Ф В ок.б) (в тис.): ').argument(:required).read_int * 1000

## Input table
system('clear')
input_table << ['Плановий РП', PRP] << ['Фактичний РП', FRP]
input_table << ['Плановий В об.к', PVobk] << ['Фактичний В об.к', FVobk]
puts input_table.render(:unicode)

## Calculations
# Коефіцієнт оборотності (плановий)
Kobp = PRP.to_f / PVobk.to_f 
# Коефіцієнт оборотності (фактичний)
Kobf = FRP.to_f / FVobk.to_f
# Тривалість одного обороту (плановий)
Tobp = 360 / Kobp.to_f
# Тривалість одного обороту (фактичний)
Tobf = 360 / Kobf.to_f
# Прискорення оборотності оборотних коштів
Tob = Tobp.to_f - Tobf.to_f
# Вивільнення оборотних коштів в результаті прискорення  
Vobk = FRP.to_f / 360 * Tob.to_f

# Rendering
output_table << ['Коефіцієнт оборотності (плановий)', 'К об план', '%.1f' % Kobp] << ['Коефіцієнт оборотності (фактичний)', 'К об факт','%.1f' % Kobf]
output_table << ['Тривалість одного обороту (плановий)', 'Т об план','%.1f' % Tobp] << ['Тривалість одного обороту (фактичний)', 'Т об факт','%.1f' % Tobf]
output_table << ['Прискорення оборотності оборотних коштів', "\u25B5Т об",'%.1f' % Tob] << ['Вивільнення оборотних коштів в результаті прискорення', "\u25B5В об. к",'%.1f' % Vobk]
puts output_table.render(:unicode, width:90, resize:true)
