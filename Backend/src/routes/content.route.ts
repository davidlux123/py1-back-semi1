import { Router } from 'express'
import { healthy, uploadImage, uploadMp3, download } from '../controllers/content.controller'
import multer from 'multer';

const router = Router();
const upload = multer();

router.post('/uploadImage', uploadImage)
router.post('/uploadMusic/:nameMp3', upload.single('track'), uploadMp3)
router.post('/downloadImage', download)
router.get('/ping', healthy);

export default router;
