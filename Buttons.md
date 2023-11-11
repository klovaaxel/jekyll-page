#WebDevelopment #HTML #Button #NativeComponent
## References
+ https://accessibleweb.dev/buttons
+ https://dev.opera.com/articles/ux-accessibility-aria-label/#accessible-name-calculation
## When to use a button

Don't let CSS dictate which element you use. The styling can always be changed. A simple rule of thumb is to think about what the element should do. Buttons are for actions and links are to take you to new places.

**Is it performing an action like opening a modal, a menu or some other popup? Is it applying some styling to a page like a bold or italic button in a text editor? Is it allowing you to save something or search for something? Then you should probably use a button.**

Is it taking you to another page or another area of the page? Then it should probably be a link.

## How to use a button

### Text Button

If you only have a single text button you don't need more than this:
```html
<button type="button" onclick="handleClick()">Text here</button>
```
It gets its accessible name from the text between the opening and closing button tags. If your text clearly explains the button's purpose then this is an accessible button.

If you however have multiple buttons all with the same name you should consider a aria label or including some extra text for screen readers. 

#### Aria-label
It is important that the start of the aria-label matches with the visible text on the button to help users of speech input software be able to activate the button.
```html 
<button type="button" onclick="handleClick()" aria-label="Add to cart product 1">
	Add to cart
</button>
<button type="button" onclick="handleClick()" aria-label="Add to cart product 2">
	Add to cart
</button>
<button type="button" onclick="handleClick()" aria-label="Add to cart product 3">
	Add to cart
</button>
```
#### Hidden text 
It's important to be careful of word order when using this technique. If we had instead inserted the product name in the middle of the sentence, for example: "Add product 1 to basket" this can cause problems for users of speech input software.
```html 
<button type="button" onclick="handleClick()">
	Add to cart <span class="sr-only">product 1<span>
</button>
<button type="button" onclick="handleClick()">
	Add to cart <span class="sr-only">product 2<span>
</button>
<button type="button" onclick="handleClick()">
	Add to cart <span class="sr-only">product 3<span>
</button>
```


### Text and Icon Buttons
Some buttons have both text and icons inside. The icon can help complement the text and aid understanding.

To make these buttons accessible to screen readers there are a few things to keep in mind however.

If your text clearly explains the button's purpose then you should probably hide your icon from screen readers with the aria-hidden attribute. This so that the screen reader doesn't repeat itself and as simply as possible states the button's purpose 
```html
<button type="button" onclick="save()">
	<i class="fa fa-save" aria-hidden="true"></i>
	save
</button>
```

However if your text doesn't explain your buttons purpose with just the text, you can always add more, hidden, text to explain the buttons purpose. 
```html
<button type="button" onclick="save()">
	<i class="fa fa-save" aria-hidden="true"></i>
	save
	<span class="sr-only">your changes</span>
</button>
```

### Icon Buttons
Some buttons may only have a icon, when this is the case we need to make sure we state the purpose of our button in some other way that visually with the icon. Even people who can see your icon may not always understand what clicking it does

We can explain what our button does with a `title` attribute. This way when the button is hovered we get a tooltip explaining the action or purpose of our button. 
*Just take in to consideration that this tooltip will be not be accessible for mobile or other forms of touch users*
```html
<button type="button" onclick="save()" title="save">
	<i class="fa fa-save" aria-hidden="true"></i>
</button>
```

However when some screen reader comes across this button they wont read the `title` attribute so to be extra sure _all_ screen readers know how to process our icon button we can add a `aria-label` attribute as well. [read more about the title and aria-label attributes](https://dev.opera.com/articles/ux-accessibility-aria-label/#accessible-name-calculation)
```html
<button type="button" onclick="save()" title="save" aria-label="save">
	<i class="fa fa-save" aria-hidden="true"></i>
</button>
```