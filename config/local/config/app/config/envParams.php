<?php

return [
    'baseUrl' => 'https://cloud.pmmimediagroup.com',
    'errantFieldsMailTo' => ['[[[FILL]]]'],
    'adbuilderUrl' => 'https://adbuilder.pmmimediagroup.com/', 
    'gamePlanApiUrl' => 'http://gravada-production-2021.us-east-1.elasticbeanstalk.com/',
    'brandInfo' => [
        1 => [
            'abbrev' => 'PW',
            'website' => 'docker.for.mac.host.internal:8642'
        ],
        2 => [
            'abbrev' => 'AW',
            'website' => 'http://dev.automationworld.com'
        ],
        3 => [
            'abbrev' => 'HCP',
            'website' => ''
        ],
        4 => [
            'abbrev' => 'PP-OEM',
            'website' => ''
        ],
        5 => [
            'abbrev' => 'OPX',
            'website' => ''
        ],
        6 => [
            'abbrev' => 'DW',
            'website' => ''
        ],
        7 => [
            'abbrev' => 'LatAm',
            'website' => ''
        ],
        8 => [
            'abbrev' => 'PFW',
            'website' => ''
        ]
    ],
    'campaignsWithoutMailingIdExportEmail' => '[[[FILL]]]',
    'prospector_api_url' => 'https://prospector.pmmimediagroup.com',
    'prospector_fe_url' => 'http://localhost:3000/dist',
    'mongoClientUri' => '[[[FILL]]]',
    'omeda_base_url' => 'https://ows.omeda.com/webservices/rest/brand/PMMICD',
    'omeda_app_id' => '[[[FILL]]]',
    'omeda_input_id' => '[[[FILL]]]',
    'cvalSimilarityToolUrl' => '[[[FILL]]]',
    'sendGridApiKey' => '[[[FILL]]]',
    'send_emails' => false,

    'cvalPromoCode' => [
        'default' => 'PELV19',
        'epm' => 'EPM_2020',
    ],

    'cvalBehaviorId' => [
        'epm' => 59,
    ],

    'ebuilder-advertisers' => [],

    'doSmartyMatch' => true,

    'webflowApi' => [
        'key' => '[[[FILL]]]',
        'baseUrl' => 'https://api.webflow.com',
        'smaAdCollectionId' => '[[[FILL]]]',
    ],

    'map_your_show' => [
        'api_url' => 'https://api.mysstaging.com/mysRest/v2',
        'user_name' => '[[[FILL]]]',
        'password' => '[[[FILL]]]',
        'show_code' => 'PECONNECTS20',
    ],

    'playbookCampaignTemplateIds' => [
        345,
        359,
    ],

    'naviga_api_url' => 'https://pmgtest.navigahub.com/ElanWebPlatform/PMG/',

    'naviga_auth_token' => '[[[FILL]]]',

    'naviga_last_updated_past_minutes' => 5000,

    'adBuilderQueryPercentages' => false,

    's3OmedaCompanyValidationBucket' => 'leadworks-omeda-company-validation',

    'omedaCompanyValidationSqsUrl' => '[[[FILL]]]',
];
