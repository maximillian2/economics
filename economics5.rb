require 'tty'

# Setup
shell = TTY::Shell.new
input_table = TTY::Table.new(header: ['Вхідні дані', 'Введене число'])
output_table = TTY::Table.new(header: ['Результати', 'Скорочення', 'Відповідь'])

## Greeting
shell.say('Практична робота №5')
shell.say('Розрахунок показників економічної ефективності впровадження нової техніки')
shell.warn('Введіть потрібні дані:')

## Input
Z1 = shell.ask("Введіть умовно-змінні витрати (1 варіант) (З 1): ").argument(:required).read_int
Z2 = shell.ask("Введіть умовно-змінні витрати (2 варіант) (З 2): ").argument(:required).read_int

P1 = shell.ask("Введіть умовно-постійні витрати (1 варіант) (\u03A3П 1) (в тис.): ").argument(:required).read_int * 1000
P2 = shell.ask("Введіть умовно-постійні витрати (2 варіант) (\u03A3П 2) (в тис.): ").argument(:required).read_int * 1000

K1 = shell.ask("Введіть річний випуск виробу (1 варіант) (К 1): ").argument(:required).read_int
K2 = shell.ask("Введіть річний випуск виробу (2 варіант) (К 2): ").argument(:required).read_int

C1 = shell.ask("Введіть відпускну ціну обладнання (1 варіант) (Ц 1): ").argument(:required).read_int
C2 = shell.ask("Введіть відпускну ціну обладнання (2 варіант) (Ц 2): ").argument(:required).read_int

## Input table
system('clear')
input_table << ['З 1', Z1] << ['З 2', Z2]
input_table << ["\u03A3П1", P1] << ["\u03A3П2", P2]
input_table << ['К1', K1] << ['К2', K2]
input_table << ['Ц1', C1] << ['Ц2', C2]
puts input_table.render(:unicode)

## Calculations and rendering 
# Собівартість річного випуску виробу при К1
K1Csht1 = Z1 + P1.to_f / K1.to_f
K1Csht2 = Z2 + P2.to_f / K1.to_f
output_table << ['Технологічна собівартість одиниці виробу за 1 варіантом', 'С шт1 при К1', '%.2f' % K1Csht1]
output_table << ['Технологічна собівартість одиниці виробу за 2 варіантом', 'С шт2 при К1', '%.2f' % K1Csht2]

# Собівартість річного випуску виробу при К2
K2Csht1 = Z1 + P1.to_f / K2.to_f
K2Csht2 = Z2 + P2.to_f / K2.to_f
output_table << ['Технологічна собівартість одиниці виробу за 1 варіантом', 'С шт1 при К2', '%.2f' % K2Csht1]
output_table << ['Технологічна собівартість одиниці виробу за 2 варіантом', 'С шт2 при К2', '%.2f' % K2Csht2]

# Критична програма 
Kkr = (P1 - P2).abs.to_f / (Z1 - Z2).abs.to_f
output_table << ['Критична програма', 'К кр', '%.0f' % Kkr]

# Технологічна собівартість одиниці виробу
Csht = Z1 + P1.to_f / Kkr.to_f
output_table << ['Технологічна собівартість одиниці виробу по  К кр', 'С шт1 = С шт2', '%.2f' % Csht]

# Річний економічний ефект при К1
# Е н = 0.15 => constant
# 1.1 = 110%
K1Er = (K1.to_f * K1Csht1.to_f.round(2) + 0.15 * C1.to_f * 1.1) - (K1Csht2.to_f.round(2) * K1.to_f + 0.15 * C2.to_f * 1.1)
output_table << ['Річний економічний ефект за К1', 'Ер за К1', '%.1f' % K1Er]

# Умовно-річна економія при K1
K1Eur = K1.to_f * K1Csht1.to_f.round(2) - K1.to_f * K1Csht2.to_f.round(2)
output_table << ['Умовно-річна економія при К1', 'Е ур за К1', '%.2f' % K1Eur]

# Строк окупності при К1
K1Tok = (C2.to_f * 1.1 - C1.to_f * 1.1) / K1Eur
output_table << ['Строк окупності (1)', 'Т ок', '%.2f' % K1Tok]

# Річний економічний ефект від впровадження нової техніки при К2
K2Er = (K2.to_f * K2Csht1.to_f.round(2) + 0.15 * C1.to_f * 1.1) - (K2.to_f * K2Csht2.to_f.round(2) + 0.15 * C2.to_f * 1.1)
output_table << ['Річний економічний ефект від впровадження нової техніки при К2', 'Ер за К2', '%.1f' %  K2Er]

# Умовно-річна економія при К2
K2Eur = K2.to_f * K2Csht1.to_f.round(2) - K2.to_f * K2Csht2.to_f.round(2)
output_table << ['Умовно-річна економія при K2', 'Е ур за К2', '%.2f' % K2Eur]

# Строк окупності при К2
K2Tok = (C2.to_f * 1.1 - C1.to_f * 1.1) / K2Eur.to_f
output_table << ['Строк окупності (2)', 'Т ок', '%.2f' % K2Tok]

puts output_table.render(:unicode, width: 120, resize: true)
