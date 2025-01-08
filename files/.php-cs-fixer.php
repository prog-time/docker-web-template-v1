<?php

use PhpCsFixer\Config;
use PhpCsFixer\Finder;

/* включить в проверку */
$includeList = [
    'src',
];

/* исключить из проверки */
$excludeList = [
    'vendor',
    'npm',
    'node_modules',
];

$finder = PhpCsFixer\Finder::create()
    ->in($includeList)
    ->exclude($excludeList)
    ->name('*.php') // Укажите тип файлов, которые будут проверяться
    ->notName('*.blade.php') // Исключите файлы Blade шаблонов (если используете Laravel)
    ->ignoreDotFiles(true) // Игнорируйте скрытые файлы
    ->ignoreVCS(true); // Игнорируйте VCS файлы (например, .git)

return (new PhpCsFixer\Config())
    ->setRules([
        '@PSR12' => true, // Применение стандартов PSR-12
        'array_syntax' => ['syntax' => 'short'], // Использование короткого синтаксиса массивов []
        'binary_operator_spaces' => ['default' => 'single_space'], // Выравнивание операторов
        'blank_line_after_namespace' => true,    // Пустая строка после объявления пространства имен
        'blank_line_after_opening_tag' => true,  // Пустая строка после открывающего тега PHP
        'cast_spaces' => ['space' => 'single'],  // Пробелы для приведения типов
        'class_attributes_separation' => [
            'elements' => [
                'const' => 'one',
                'method' => 'one',
                'property' => 'one'
            ],
        ],
        'concat_space' => ['spacing' => 'one'],  // Пробел при конкатенации строк
        'function_declaration' => ['closure_function_spacing' => 'one'], // Пробелы в объявлениях функций
        'indentation_type' => true,              // Использование пробелов вместо табуляций
        'line_ending' => true,                   // Концы строк Unix-стиля
        'lowercase_keywords' => true,            // Приведение ключевых слов к нижнему регистру
        'no_unused_imports' => true,             // Удаление неиспользуемых импортов
        'single_quote' => true,                  // Использование одинарных кавычек вместо двойных
        'trailing_comma_in_multiline' => ['elements' => ['arrays']], // Запятая в конце многострочных массивов
    ])
    ->setFinder($finder);
