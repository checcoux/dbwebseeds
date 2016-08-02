// qui vengono definiti gli stili che saranno mostrati nel dropdown degli editor inline
// gli stili dovranno avere una corrispondenza nei css del sito

CKEDITOR.stylesSet.add( 'my_styles', [
    // Block-level styles
    { name: 'Blue Title', element: 'h2', attributes: { 'class': 'bleu' } },
    { name: 'Red Title' , element: 'h3', attributes: { 'class': 'rouge' } },

    // Inline styles
    { name: 'CSS Style', element: 'span', attributes: { 'class': 'my_style' } },
    { name: 'Marker: Yellow', element: 'span', styles: { 'background-color': 'Yellow' } },
    { name: 'Mio stile', element: 'span', attributes: { 'class': 'miostile' } }
] );
