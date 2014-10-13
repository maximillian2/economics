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
input_table << ['Tpl', Tpl] << ['Fe', Fe]
input_table << ['Kvn', Kvn] << ['percentChdr', percentChdr]
input_table << ['percentChitr', percentChitr] << ['percentChsl', percentChsl]
input_table << ['percentChmop', percentChmop]
puts input_table.render(:unicode)

## Calculations

##
Chop = Tpl / (Fe * Kvn)
##
Chdr = percentChdr * Chop
##
Chitr = percentChitr * Chop
##
Chsl = percentChsl * Chop
##
Chmop = percentChmop * Chop

## Rendering
output_table << ['Chop', 'Chop', Chop]
output_table << ['Chdr', 'Chdr', Chdr]
output_table << ['Chitr', 'Chitr', Chitr]
output_table << ['Chsl', 'Chsl', Chsl]
output_table << ['Chmop', 'Chmop', Chmop]
puts output_table.render(:unicode, width: 90, resize: true)
