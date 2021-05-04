import React, { useEffect, useState } from 'react';
import { FaStar, FaEye } from 'react-icons/fa'
import { CgGitFork } from 'react-icons/cg'
import { useParams } from 'react-router'

import { IRepoDetail, IRouteParams } from './interfaces';

import api from '../../services/api'

import './styles.css'

const Details: React.FC = () => {
    const { id } = useParams<IRouteParams>()

    const [single, setSingle] = useState<IRepoDetail | null>(null)

    useEffect(() => {
        const fetchDetail = async () => {
            const result = await api.get(`/repos/${id}`)

            if (result.data) {
                const { data }: { data: IRepoDetail } = result.data

                setSingle(data)
            }
        }

        fetchDetail()
    }, [id])

    return (
        <div className="container-fluid default-container">
            {
                single
                    ? (
                        <div>
                            <div className="d-flex flex-row align-items-start justify-content-between">
                                <div className="d-flex flex-row align-items-start w-100">
                                    <img src={single.avatar} alt="repo_img" className="owner-logo" />
                                    <div className="d-flex flex-column repo-description-container">
                                        <h3><a target="_blank" href={single.repo_page}>{single.full_name}</a></h3>
                                        <p>{single.repo_description}</p>
                                        <div className="counter-container d-flex flex-row align-items-center justify-content-between w-75">
                                            <span className="d-flex flex-row align-items-center">
                                                <FaStar />
                                                <p>{single.stars_count}</p>
                                            </span>
                                            <span className="d-flex flex-row align-items-center">
                                                <CgGitFork />
                                                <p>{single.forks_count}</p>
                                            </span>
                                            <span className="d-flex flex-row align-items-center">
                                                <FaEye />
                                                <p>{single.watchers_count}</p>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                {
                                    single.repo_homepage !== ''
                                        ? (
                                            <div className="h-50 d-flex flex-row align-items-center mr-4 mt-4">
                                                <FaStar />
                                                <a
                                                    target="_blank"
                                                    href={single.repo_homepage}
                                                    className="mx-2 get-started-link"
                                                >
                                                    Get started!
                                                        </a>
                                            </div>
                                        )
                                        : null
                                }
                            </div>
                            <div>
                                <p>Owner: <a target="_blank" href={single.owner_page}>{single.owner}</a></p>
                            </div>
                        </div>
                    )
                    : null
            }
        </div>
    );
}

export default Details;