package com.caffeineshawn.db_backend.mapper;

import com.caffeineshawn.db_backend.entity.Track;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface TrackMapper {

    List<Track> findTrackByGoodId(int Good_id);
}
