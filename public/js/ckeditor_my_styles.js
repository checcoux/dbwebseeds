// qui vengono definiti gli stili che saranno mostrati nel dropdown degli editor inline
// gli stili dovranno avere una corrispondenza nei css del sito

CKEDITOR.stylesSet.add( 'my_styles', [
    // Object-level styles
    { name: 'Menu', element: 'ul', attributes: { 'class': 'vertical medium-horizontal menu' } },
    { name: 'Bottone (primary)', element: 'a', attributes: { 'class': 'button' } },
    { name: 'Bottone (secondary)', element: 'a', attributes: { 'class': 'secondary button' } },
    { name: 'Bottone (success)', element: 'a', attributes: { 'class': 'success button' } },
    { name: 'Bottone (warning)', element: 'a', attributes: { 'class': 'warning button' } },
    { name: 'Bottone (alert)', element: 'a', attributes: { 'class': 'alert button' } },
    { name: 'Bottone (disabled)', element: 'a', attributes: { 'class': 'disabled button' } },

    { name: 'Bottone vuoto (primary)', element: 'a', attributes: { 'class': 'hollow button' } },
    { name: 'Bottone vuoto (secondary)', element: 'a', attributes: { 'class': 'hollow secondary button' } },
    { name: 'Bottone vuoto (success)', element: 'a', attributes: { 'class': 'hollow success button' } },
    { name: 'Bottone vuoto (warning)', element: 'a', attributes: { 'class': 'hollow warning button' } },
    { name: 'Bottone vuoto (alert)', element: 'a', attributes: { 'class': 'hollow alert button' } },
    { name: 'Bottone vuoto (disabled)', element: 'a', attributes: { 'class': 'hollow disabled button' } },

    // Block-level styles
    { name: 'Bleue Title', element: 'h2', attributes: { 'class': 'bleu' } },
    { name: 'Red Title' , element: 'h3', attributes: { 'class': 'rouge' } },

    // Inline styles
    { name: 'CSS Style', element: 'span', attributes: { 'class': 'my_style' } },
    { name: 'Marker: Yellow', element: 'span', styles: { 'background-color': 'Yellow' } },
    { name: 'Mio stile', element: 'span', attributes: { 'class': 'miostile' } }
] );
