import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
import 'package:flutter_complete_guide/providers/product.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/EditScreen';
  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _pricefocusnode = FocusNode();
  final _descriptionfocusnode = FocusNode();
  final _imageUrlfocusnode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();

  var editingProduct = Product(
    id: null,
    title: '',
    description: '',
    price: 0,
    imageUrl: '',
  );
  var _initValues = {
    'title': '',
    'description': '',
    'price': '',
    'imageURL': '',
  };
  var _isInit = true;
  var _isLoading = false;
  @override
  void initState() {
    _imageUrlfocusnode.addListener(_updateImageUrl);
    super.initState();
  }

  void _updateImageUrl() {
    if (!_imageUrlfocusnode.hasFocus) {
      setState(() {});
    }
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final ProductID = ModalRoute.of(context).settings.arguments as String;
      if (ProductID != null) {
        editingProduct = Provider.of<Products>(
          context,
          listen: false,
        ).findById(ProductID);
        _initValues = {
          'title': editingProduct.title,
          'description': editingProduct.description,
          'price': editingProduct.price.toString(),
          'imageURL': '',
        };
        _imageUrlController.text = editingProduct.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imageUrlfocusnode.removeListener(_updateImageUrl);
    _pricefocusnode.dispose();
    _descriptionfocusnode.dispose();
    _imageUrlController.dispose();
    _imageUrlfocusnode.dispose();
    super.dispose();
  }

  Future<void> _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) return;
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });

    if (editingProduct.id != null) {
      await Provider.of<Products>(context, listen: false)
          .updateProducts(editingProduct.id, editingProduct);
      Navigator.of(context).pop();
    } else {
      try {
        await Provider.of<Products>(context, listen: false)
            .addProduct(editingProduct);
      } catch (error) {
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('An error occured!'),
            content: Text('something went wrong.'),
            actions: [
              FlatButton(
                textColor: Theme.of(context).errorColor,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('okay'),
              ),
            ],
          ),
        );
      }
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: [
          IconButton(
            onPressed: _saveForm,
            icon: Icon(Icons.save_alt),
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
                  children: [
                    TextFormField(
                      initialValue: _initValues['title'],
                      decoration: InputDecoration(labelText: 'Title'),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value.isEmpty) return 'Please provide a Title';
                        return null;
                      },
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_pricefocusnode);
                      },
                      onSaved: (value) {
                        editingProduct = Product(
                          id: editingProduct.id,
                          title: value,
                          description: editingProduct.description,
                          price: editingProduct.price,
                          imageUrl: editingProduct.imageUrl,
                          isfavorite: editingProduct.isfavorite,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['price'],
                      decoration: InputDecoration(labelText: 'price'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      focusNode: _pricefocusnode,
                      validator: (value) {
                        if (value.isEmpty) return 'Please provide a Price';
                        if (double.tryParse(value) == null)
                          return 'Please Enter a valid number!';
                        if (double.parse(value) <= 0.0)
                          return 'Please Enter a number greater than Zero!!';
                        return null;
                      },
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_descriptionfocusnode);
                      },
                      onSaved: (value) {
                        editingProduct = Product(
                          id: editingProduct.id,
                          title: editingProduct.title,
                          description: editingProduct.description,
                          price: double.parse(value),
                          imageUrl: editingProduct.imageUrl,
                          isfavorite: editingProduct.isfavorite,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['description'],
                      decoration: InputDecoration(labelText: 'Description'),
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      focusNode: _descriptionfocusnode,
                      validator: (value) {
                        if (value.isEmpty)
                          return 'Please provide a Description';
                        if (value.length < 10)
                          return 'Should be at least 10 characters long .';
                        return null;
                      },
                      onSaved: (value) {
                        editingProduct = Product(
                          id: editingProduct.id,
                          title: editingProduct.title,
                          description: value,
                          price: editingProduct.price,
                          imageUrl: editingProduct.imageUrl,
                          isfavorite: editingProduct.isfavorite,
                        );
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.only(
                            top: 8,
                            right: 10,
                          ),
                          decoration: BoxDecoration(
                              border: Border.all(
                            width: 1,
                            color: Colors.grey,
                          )),
                          child: _imageUrlController.text.isEmpty
                              ? Text(
                                  'Enter a URL',
                                  textAlign: TextAlign.center,
                                )
                              : FittedBox(
                                  child: Image.network(
                                    _imageUrlController.text,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(labelText: 'Image URL'),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            controller: _imageUrlController,
                            focusNode: _imageUrlfocusnode,
                            validator: (value) {
                              if (value.isEmpty)
                                return 'Please provide a ImageURL';
                              if (!value.startsWith('http') &&
                                  !value.startsWith('https'))
                                return 'Please enter a valid URL';
                              if (!value.endsWith('.png') &&
                                  !value.endsWith('.jpg') &&
                                  !value.endsWith('jpeg'))
                                return 'Please Enter a Valid image Url';
                              return null;
                            },
                            onEditingComplete: () {
                              setState(() {});
                              _saveForm();
                            },
                            onSaved: (value) {
                              editingProduct = Product(
                                id: editingProduct.id,
                                title: editingProduct.title,
                                description: editingProduct.description,
                                price: editingProduct.price,
                                imageUrl: value,
                                isfavorite: editingProduct.isfavorite,
                              );
                            },
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
