package com.caffeineshawn.db_backend.mapper;

import com.caffeineshawn.db_backend.entity.Track;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface TrackMapper {

    List<Track> findOrderTrack(int order_id);

    int addTrack(Track track);

    Track findTrack(Track track);

    int deleteSpecificTrack(Track track);

    int updateTrack(Track oldTrack, Track newTrack);

    int deleteTrack(int order_id);
}
