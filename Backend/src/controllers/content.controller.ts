import { Request, Response } from 'express'
import { S3Params, S3ParamsGetFile } from '../interfaces/aws.interface';
import {configS3} from '../configs/aws.config'
import aws from 'aws-sdk'
aws.config.update(configS3)

const s3 = new aws.S3();

export const uploadImage = (req: Request, res: Response) => {
    const {namePhoto, photo} = req.body

    if ( !namePhoto || !photo ) return res.status(400).json({message: 'upload image fail: Invalid request'});

    const urlImage = `fotos/${namePhoto}`;
    const bufferImage = Buffer.from(photo, 'base64'); // Convertir la imagen de base 64 a un buffer

    const params: S3Params = {
        Bucket     : process.env.AWS_BUCKET_NAME as string,
        Key        : urlImage,
        Body       : bufferImage,
        ContentType: 'image'
    };

    s3.upload(params, ( err: Error, data: aws.S3.ManagedUpload.SendData ) => {
        if ( err ) return res.status(500).json({ message: 'upload image fail', error: err });
        return res.status(200).json({ message: 'upload images succesfully', data });
    });
    
    //luego de subir la imagen se almacena en la base de datos
};

export const uploadMp3 = (req: Request, res: Response) => {
    const { nameMp3 } = req.params;
    const { file: mp3 } = req;
    
    if ( !nameMp3 || !mp3 ) return res.status(400).json({message: 'upload audio fail: Invalid request'});
    
    const bufferMp3 = mp3.buffer as Buffer;
    const urlMp3 = `musica/${nameMp3}`;
    
    const params: S3Params = {
        Bucket     : process.env.AWS_BUCKET_NAME as string,
        Key        : urlMp3,
        Body       : bufferMp3,
        ContentType: 'audio/mpeg'
    }
    
    s3.upload(params, ( err: Error, data: aws.S3.ManagedUpload.SendData ) => {
        if ( err ) return res.status(500).json({ message: 'upload audio fail', error: err });
        return res.status(200).json({ message: 'upload audio succesfully', data });
    });
};

export const download = (req: Request, res: Response) => {
    const { namePhoto } = req.body;
    const urlImage = `fotos/${namePhoto}`;
    
    //verificar ya en la base de datos que si exista la imagen
    
    const paramsGetFileS3: S3ParamsGetFile = {
        Bucket: process.env.AWS_BUCKET_NAME as string,
        Key   : urlImage
    };
    
    s3.getObject(paramsGetFileS3, (err: aws.AWSError, data: aws.S3.GetObjectOutput) => {
        if (err) return res.status(500).json({ message:'Download file fail' ,error:err });
        
        // Parser la imagen a base64
        const image = Buffer.from(data.Body as Buffer).toString('base64');
        return res.status(200).json({ message: 'Download file succesfully', image });  
    });
    
};

export const healthy = (req: Request, res: Response) => {
    return res.status(200).json({ msg: 'true' })
} 
