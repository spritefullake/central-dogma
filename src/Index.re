[%raw {|require('../index.css')|}];
let checkMode : unit => unit = [%raw {|
    () => {
        if(process.env.NODE_ENV !== 'production') {
        console.log('Looks like we are in development mode!');
        }
    }
|}];
checkMode();
ReactDOMRe.renderToElementWithId(<Dashboard/>,"root")