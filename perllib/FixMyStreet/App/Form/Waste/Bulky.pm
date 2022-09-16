package FixMyStreet::App::Form::Waste::Bulky;

use utf8;
use HTML::FormHandler::Moose;
extends 'FixMyStreet::App::Form::Waste';

has_page intro => (
    title => 'Book bulky goods collection',
    intro => 'bulky/intro.html',
    fields => ['continue'],
    next => 'residency_check',
);

has_page residency_check => (
    title => 'Book bulky goods collection',
    fields => ['resident', 'continue'],
    next => 'about_you',
);

has_page about_you => (
    fields => ['name', 'email', 'phone', 'continue'],
    title => 'About you',
    next => 'choose_date',
);

with 'FixMyStreet::App::Form::Waste::AboutYou';

has_page choose_date => (
    fields => ['continue', 'chosen_date'],
    title => 'Choose date for collection',
    next => 'add_items',
);

has_page add_items => (
    fields => ['continue', 'item1', 'item2', 'item3', 'item4', 'item5'], # XXX build list dynamically
    title => 'Add items for collection',
    next => 'summary',
);


has_page summary => (
    fields => ['submit', 'tandc'],
    title => 'Submit collection booking',
    template => 'waste/bulky/summary.html',
    next => 'done',
);

has_page done => (
    title => 'Collection booked',
    template => 'waste/bulky/confirmation.html',
);


has_field continue => (
    type => 'Submit',
    value => 'Continue',
    element_attr => { class => 'govuk-button' },
    order => 999,
);

has_field submit => (
    type => 'Submit',
    value => 'Continue to payment',
    element_attr => { class => 'govuk-button' },
    order => 999,
);

has_field resident => (
    type => 'Select',
    widget => 'RadioGroup',
    required => 1,
    label => 'Are you the resident of this property or booking on behalf of the property resident?',
    options => [
        { label => 'Yes', value => 'Yes' },
        { label => 'No', value => 'No' },
    ],
);

has_field chosen_date => (
    type => 'Select',
    widget => 'RadioGroup',
    required => 1,
    label => 'Available dates',
    options => [
        # XXX look these up dynamically
        { value => '20220825', label => '2022-08-25' },
        { value => '20220826', label => '2022-08-26' },
        { value => '20220827', label => '2022-08-27' },
        { value => '20220828', label => '2022-08-28' },
    ],
);

has_field tandc => (
    type => 'Checkbox',
    required => 1,
    label => 'Terms and conditions',
    option_label => FixMyStreet::Template::SafeString->new(
        'I agree to the <a href="/about/bulky_terms" target="_blank">terms and conditions</a>',
    ),
);


# XXX yuck
sub item_field {
    (
        type => 'Select',
        widget => 'Select',
        label => 'Item ' . shift,
        tags => { last_differs => 1, small => 1, autocomplete => 1 },
        options => [
            # XXX look these up dynamically
            { value => 'chair', label => 'Armchair' },
            { value => 'sofa', label => 'Sofa' },
            { value => 'table', label => 'Table' },
            { value => 'fridge', label => 'Fridge' },
        ],
    )
}

# XXX yuck yuck
has_field item1 => item_field(1);
has_field item2 => item_field(2);
has_field item3 => item_field(3);
has_field item4 => item_field(4);
has_field item5 => item_field(5);

1;