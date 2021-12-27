package com.caffeineshawn.db_backend.service;

import com.caffeineshawn.db_backend.entity.Track;
import com.caffeineshawn.db_backend.mapper.TrackMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;

@Service
public class TrackService {
    @Resource
    TrackMapper trackMapper;

    @Transactional
    public int addTrack(Track track){return trackMapper.addTrack(track);}

    public Track findTrack(Track track) {
        return  trackMapper.findTrack(track);
    }

    @Transactional
    public int updateTrack(Track oldTrack, Track newTrack){
        return trackMapper.updateTrack(oldTrack, newTrack);
    }

    @Transactional
    public int deleteSpecificTrack(Track track){
        return trackMapper.deleteSpecificTrack(track);
    }

}
