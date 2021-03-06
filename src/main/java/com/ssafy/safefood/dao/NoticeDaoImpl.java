package com.ssafy.safefood.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ssafy.safefood.vo.NoticeVO;

@Repository
public class NoticeDaoImpl implements NoticeDao{

	private final String ns = "NoticeMapper.";
	
	@Autowired
	private SqlSession session;
	
	@Override
	public List<NoticeVO> selectAll() throws Exception {
		return session.selectList(ns+"selectAll");
	}

	@Override
	public NoticeVO selectByNoticeNo(int no) throws Exception {
		return session.selectOne(ns+"selectByNoticeNo", no);
	}

	@Override
	public void insertNotice(NoticeVO pvo) throws Exception {
		session.insert(ns+"insertNotice", pvo);
	}

	@Override
	public void updateNotice(NoticeVO pvo) throws Exception {
		session.update(ns+"updateNotice", pvo);
	}

	@Override
	public void deleteNotice(int no) throws Exception {
		session.delete(ns+"deleteNotice", no);
		
	}

}
