<?php

return PhpCsFixer\Config::create()
    ->setRules(array(
        //'@Symfony' => true,
        //trim_array_namespace' => true,
        'blank_line_after_opening_tag' => false,
        'braces' => array(
            //'allow_single_line_closure' => true,
            //'position_after_anonymous_constructs' => 'next'
            'position_after_control_structures' => 'next'
        ),
        //'method_separation' => false,
        //'method_chaining_indentation' => true,
            ))
    ->setIndent("  ")
    ->setLineEnding("\n");
