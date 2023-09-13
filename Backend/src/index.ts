import express, { Application } from 'express'
import morgan from 'morgan'
import cors from 'cors'
import 'dotenv/config'
import router from './routes/content.route'

// import {configS3} from './config/aws.config' 
// console.log(configS3);

const app: Application = express()

// settings
app.set('port', process.env.PORT)

// middlewares
app.use(morgan('dev'))
app.use(cors({ origin: '*' }))
app.use(express.urlencoded({ limit: '10mb', extended: true }))
app.use(express.json({ limit: '10mb' }))

// routes
app.use(router)

const PORT = app.get('port');
const main = () => {
    app.listen(PORT, () => console.log(`Running on PORT: ${PORT}`))
}
  
main();