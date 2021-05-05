import Axios from 'axios'

export default Axios.create({
    baseURL: `http://${process.env.API_HOST}:4000/api`
})

