require 'tty'

# Setup
shell = TTY::Shell.new
input_table = TTY::Table.new(header: ['Вхідні дані', 'Введене число'])
output_table = TTY::Table.new(header: ['Результати', 'Скорочення', 'Відповідь'])

## Greeting
shell.say('Практична робота №2')
shell.say('Розрахунок чисельності працюючих за категоріями')
shell.warn('Введіть потрібні дані:')

## Input
Tpl = shell.ask('Планова трудомісткість річної програми випуску всіх виробів (Т пл): ').argument(:required).read_int
Fe = shell.ask(' (Ф е): ').argument(:required).read_int
Kvn = shell.ask('Середній коефіцієн винонання норм на підприємстві (К вн): ').argument(:required).read_float
percentChdr = shell.ask('Чисельність допоміжних робочих (% Ч др): ').argument(:required).read_float / 100.0
percentChitr = shell.ask('Чисельність інженерно-технічних (% Ч ітр): ').argument(:required).read_float / 100.0
percentChsl = shell.ask('Чисельність службовців (% Ч сл): ').argument(:required).read_float / 100.0
percentChmop = shell.ask('Чисельність молодшого обслуговуючого персоналу (% Ч моп): ').argument(:required).read_float / 100.0

## Input table
system('clear')
input_table << ['Т пл', Tpl] << ['Ф е', Fe]
input_table << ['К вн', Kvn] << ['% Ч др', percentChdr]
input_table << ['% Ч ітр', percentChitr] << ['% Ч сл', percentChsl]
input_table << ['% Ч моп', percentChmop]
puts input_table.render(:unicode)

## Calculations

## Чисельність основних робочих 
Chop = Tpl / (Fe * Kvn)
## Чисельність допоміжних робочих
Chdr = percentChdr * Chop
## Чисельність інженерно-технічних робочих
Chitr = percentChitr * (Chop + Chdr)
## Чисельність службовців
Chsl = percentChsl * (Chop + Chdr)
## Чисельність молодшого обслуговуючого персоналу
Chmop = percentChmop * (Chop + Chdr)

## Rendering
output_table << ['Чисельність основних робочих', 'Chop', '%.0f' % Chop]
output_table << ['Чисельність допоміжних робочих', 'Chdr', '%.0f' % Chdr]
output_table << ['Чисельність інженерно-технічних робочих', 'Chitr', '%.0f' % Chitr]
output_table << ['Чисельність службовців', 'Chsl', '%.0f' % Chsl]
output_table << ['Чисельність молодшого обслуговуючого персоналу', 'Chmop', '%.0f' % Chmop]
puts output_table.render(:unicode, width: 90, resize: true)
