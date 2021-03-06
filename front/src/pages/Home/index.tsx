import React, { useCallback, useEffect, useState } from 'react';
import ItemCard from '../../compenents/ItemCard';
import { IRepo } from '../../utils/interfaces';

import api from '../../services/api'

import './styles.css'

const Home: React.FC = () => {
    const [data, setData] = useState<IRepo[]>([])
    const [enableButton, setEnableButton] = useState(true)

    const handleFetchData = useCallback(() => {
        const fetchData = async () => {
            setEnableButton(false)
            const result = await api.get('/repos')

            if (result.data) {
                const { data }: { data: IRepo[] } = result.data

                console.log(data)
                setData(data)
            }
            setEnableButton(true)
        }

        fetchData()
    }, [data])

    return (
        <div className="container-fluid default-container d-flex flex-column">
            <div className="data-container">
                {
                    data.length > 0
                        ? data.map(item => (
                            <ItemCard
                                item={item}
                            />
                        ))
                        : null
                }
            </div>
            <button
                onClick={handleFetchData}
                className={`fetch-button mt-3 ${data.length > 0 || !enableButton ? 'disable' : ''}`}
            >
                Fetch Data
            </button>
        </div>
    );
}

export default Home;