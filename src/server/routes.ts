import express from 'express';
import { readFileSync } from 'fs';
import { join } from 'path';
import { CheckoutResponse } from '../common/types';
import { ExampleStore } from './data';

const indexHtmlContent = readFileSync(join(__dirname, '..', '..', '..', "dist", "index.html")).toString();

const indexHtml = (req: express.Request, res: express.Response) => {
    res.send(indexHtmlContent);
};

const store = new ExampleStore();

export const router = express.Router();

router.get('/', indexHtml);
router.get('/catalog', indexHtml);
router.get('/catalog/:id', indexHtml);
router.get('/delivery', indexHtml);
router.get('/contacts', indexHtml);
router.get('/cart', indexHtml);

router.get('/api/products', (req, res) => {
    const products = store.getAllProducts();
    res.json(products);
});

router.get('/api/products/:id(\\d+)', (req, res) => {
    const id = Number(req.params.id);

    const product = store.getProductById(id);
    res.json(product);
});

router.post('/api/checkout', (req, res) => {
    const id = store.createOrder(req.body);
    const data: CheckoutResponse = { id };
    res.json(data);
});

router.get('/api/orders', (req, res) => {
    const orders = store.getLatestOrders();
    res.json(orders);
});
