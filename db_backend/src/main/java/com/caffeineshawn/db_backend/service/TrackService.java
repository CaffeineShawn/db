package com.caffeineshawn.db_backend.service;

import com.caffeineshawn.db_backend.entity.Track;
import com.caffeineshawn.db_backend.mapper.TrackMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.sql.Timestamp;
import java.util.List;

@Service
public class TrackService {
    @Resource
    TrackMapper trackMapper;

    @Transactional
    public int addTrack(Track track){return trackMapper.addTrack(track);}

    public List<Track> findTrack(Track track) {
        return  trackMapper.findTrack(track);
    }

    @Transactional
    public int updateTrack(Track track) {
        return  trackMapper.updateTrack(track);
    }

    public int deleteTrack(int order_id, String current_location, Timestamp current_time) {
        return trackMapper.deleteTrack(order_id,current_location,current_time);
    }

    @Transactional
    public int deleteSpecificTrack(Track track){
        return trackMapper.deleteSpecificTrack(track);
    }
}
