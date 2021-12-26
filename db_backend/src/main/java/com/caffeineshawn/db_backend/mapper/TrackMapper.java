package com.caffeineshawn.db_backend.mapper;

import com.caffeineshawn.db_backend.entity.Order;
import com.caffeineshawn.db_backend.entity.QueryInfo;
import com.caffeineshawn.db_backend.entity.Track;
import org.apache.ibatis.annotations.Mapper;

import java.sql.Timestamp;
import java.util.List;

@Mapper
public interface TrackMapper {

    List<Track> findOrderTrack(int order_id);

    int addTrack(Track track);

    List<Track> findTrack(Track track);

    int updateTrack(Track track);

    int deleteTrack(int order_id, String current_location, Timestamp current_time);
}
