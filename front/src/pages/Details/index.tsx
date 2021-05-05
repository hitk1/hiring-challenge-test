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
                                <div className="d-flex flex-row align-items-start w-75">
                                    <a target="_blank" href={single.owner_page}>
                                        <img src={single.avatar} alt="repo_img" className="owner-logo" />
                                    </a>
                                    <div className="d-flex flex-column repo-description-container w-100">
                                        <div className="d-flex flex-row align-items-center">
                                            <h4>
                                                <a target="_blank" href={single.repo_page}>{single.full_name}</a>
                                            </h4>
                                            <div className="tag">
                                                <p className="tag-text">{single.language}</p>
                                            </div>
                                        </div>
                                        <p>{single.repo_description}</p>
                                        <div className="counter-container d-flex flex-row align-items-center justify-content-between w-100">
                                            <div className="d-flex flex-row align-items-center justify-content-around w-50">
                                                <div className="d-flex flex-row align-items-center justify-content-center">
                                                    <FaStar />
                                                    <p>{single.stars_count}</p>
                                                </div>
                                                <div className="d-flex flex-row align-items-center justify-content-center">
                                                    <CgGitFork />
                                                    <p>{single.forks_count}</p>
                                                </div>
                                                <div className="d-flex flex-row align-items-center justify-content-center">
                                                    <FaEye />
                                                    <p>{single.watchers_count}</p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                {
                                    single.repo_homepage !== ''
                                        ? (
                                            <div className="h-50 d-flex flex-row align-items-center mr-4 mt-4">
                                                <a
                                                    target="_blank"
                                                    href={single.repo_homepage}
                                                    className="mx-2 px-2 get-started-link"
                                                >
                                                    Get started!
                                                        </a>
                                            </div>
                                        )
                                        : null
                                }
                            </div>
                        </div>
                    )
                    : null
            }
        </div>
    );
}

export default Details;