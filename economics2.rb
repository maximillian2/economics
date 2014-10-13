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
