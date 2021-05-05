import React from 'react';
import { useHistory } from 'react-router'
import { FaArrowCircleRight } from 'react-icons/fa'
import { IProps } from './interfaces';

import "./styles.css"

const ItemCard: React.FC<IProps> = ({ item }) => {
    const { push } = useHistory()

    const handleGoToDetails = React.useCallback(() => {
        push(`/detail/${item.id}`)
    }, [])

    return (
        <div className="card-container d-flex flex-row align-items-center justify-content-between px-2 w-100">
            <div className="d-flex flex-row align-items-center">
                <img src={item.avatar_url} alt="ower_img" className="repo-icon" />
                <div className="d-flex flex-column align-self-start mt-3">
                    <div className="d-flex flex-row align-items-center">
                        <p className="repo-name">{item.name}</p>
                        <div className="tag">
                            <p
                                className="tag-text"
                            >{item.language}</p>
                        </div>
                    </div>
                    <p className="repo-description">{item.description}</p>
                </div>
            </div>
            <button
                onClick={handleGoToDetails}
                className="go-to-details">
                <FaArrowCircleRight color="#588dff" />
                <p>Detalhes</p>
            </button>
        </div>
    );
}

export default ItemCard;