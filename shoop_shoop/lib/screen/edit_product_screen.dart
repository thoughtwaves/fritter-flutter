import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/products_provider.dart';
import '../model/product.dart';

class EditProductScreen extends StatefulWidget {
  static const String routeName = '/edit-product';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descFocusNode = FocusNode();
  var _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var product =
      Product(id: null, title: '', description: '', imageUrl: '', price: 0);

  var _isInit = true;
  var _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _priceFocusNode.dispose();
    _descFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
  }

  @override
  void initState() {
    super.initState();
    _imageUrlFocusNode.addListener(_updateImageUrl);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit && ModalRoute.of(context).settings.arguments != null) {
      product = ModalRoute.of(context).settings.arguments;
      _imageUrlController.text = product.imageUrl;
    }
    _isInit = false;
  }

  _updateImageUrl() {
    setState(() {});
  }

  Future<void> _saveForm() async {
    if (!_form.currentState.validate()) {
      return;
    }
    _form.currentState.save();
    if (product.id == null) {
      try {
        await Provider.of<Products>(context, listen: false).add(product);
      } catch (error) {
         showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text('Code Phat gaya'),
                  content: Text(error.toString()),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Ok'),
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                    )
                  ],
                ));
      }
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop();
    } else {
      Provider.of<Products>(context, listen: false).update(product);

      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              _saveForm();
            },
          )
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: EdgeInsets.all(15),
              child: Form(
                key: _form,
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Title'),
                      initialValue: product.title,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                      onSaved: (value) {
                        product = Product(
                            id: product.id,
                            title: value,
                            description: product.description,
                            imageUrl: product.imageUrl,
                            price: product.price);
                      },
                      validator: (value) {
                        if (value.isEmpty) return 'Please provide the title';
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Price'),
                      textInputAction: TextInputAction.next,
                      initialValue: product.price.toStringAsFixed(2),
                      keyboardType: TextInputType.number,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_descFocusNode);
                      },
                      focusNode: _priceFocusNode,
                      validator: (value) {
                        if (value.isEmpty || double.tryParse(value) == null)
                          return 'Please enter a valid Price';
                        return null;
                      },
                      onSaved: (value) {
                        product = Product(
                            id: product.id,
                            title: product.title,
                            description: product.description,
                            imageUrl: product.imageUrl,
                            price: double.parse(value));
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Description'),
                      textInputAction: TextInputAction.next,
                      initialValue: product.description,
                      keyboardType: TextInputType.multiline,
                      maxLines: 3,
                      focusNode: _descFocusNode,
                      validator: (value) {
                        if (value.isEmpty)
                          return 'Please provide the Description';
                        return null;
                      },
                      onSaved: (value) {
                        product = Product(
                            id: product.id,
                            title: product.title,
                            description: value,
                            imageUrl: product.imageUrl,
                            price: product.price);
                      },
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.only(top: 10, right: 10),
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.grey)),
                          child: Container(
                            child: _imageUrlController.text.isEmpty
                                ? Center(child: Text('No Image'))
                                : FittedBox(
                                    fit: BoxFit.cover,
                                    child: Image.network(
                                        _imageUrlController.text)),
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(labelText: 'Image Url'),
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.url,
                            controller: _imageUrlController,
                            focusNode: _imageUrlFocusNode,
                            validator: (value) {
                              if (value.isEmpty)
                                return 'Please provide the image url';
                              return null;
                            },
                            onSaved: (value) {
                              product = Product(
                                  id: product.id,
                                  title: product.title,
                                  description: product.description,
                                  imageUrl: value,
                                  price: product.price);
                            },
                            onFieldSubmitted: (_) {
                              _saveForm();
                            },
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
