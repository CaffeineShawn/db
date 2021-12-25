package com.caffeineshawn.db_backend.service;

import com.caffeineshawn.db_backend.entity.Order;
import com.caffeineshawn.db_backend.entity.QueryInfo;
import com.caffeineshawn.db_backend.entity.Track;
import com.caffeineshawn.db_backend.mapper.TrackMapper;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class TrackService {
    @Resource
    TrackMapper trackMapper;

    public int addTrack(Track track){return trackMapper.addTrack(track);}

    public List<Track> findTrack(Track track) {
        return  trackMapper.findTrack(track);
    }

    public int updateTrack(Track track) {
        return  trackMapper.updateTrack(track);
    }

    public int deleteTrack(int order_id) {
        return trackMapper.deleteTrack(order_id);
    }
}
