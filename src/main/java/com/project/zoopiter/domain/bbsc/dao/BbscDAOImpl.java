package com.project.zoopiter.domain.bbsc.dao;

import com.project.zoopiter.domain.entity.Bbsc;
import lombok.RequiredArgsConstructor;
import lombok.ToString;
import lombok.extern.slf4j.Slf4j;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.namedparam.BeanPropertySqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;
import java.util.Optional;

@ToString
@Slf4j
@Repository
@RequiredArgsConstructor
public class BbscDAOImpl implements BbscDAO{

  private final NamedParameterJdbcTemplate template;

  /**
   * 글 작성
   *
   * @param bbsc
   * @return 글번호
   */
  @Override
  public Long saveWrite(Bbsc bbsc) {
    StringBuffer sql = new StringBuffer();
    sql.append("insert into bbsc (bbsc_id , bc_title, bc_content, pet_type, bc_public, bc_gubun, user_nick) ");
    sql.append("  values(bbsc_bbsc_id_seq.nextval, :bcTitle, :bcContent, :petType, :bcPublic, :bcGubun, :userNick) ");

    KeyHolder keyHolder = new GeneratedKeyHolder();
    SqlParameterSource param = new BeanPropertySqlParameterSource(bbsc);

    template.update(sql.toString(),param, keyHolder, new String[]{"bbscId"});
    long bbscId = keyHolder.getKey().longValue(); //게시글 번호

    return bbscId;
  }

  /**
   * 목록
   *
   * @return
   */
  @Override
  public List<Bbsc> findAll() {
    StringBuffer sql = new StringBuffer();
    sql.append("select * from bbsc ");

    List<Bbsc> list = template.query(sql.toString(), new BeanPropertyRowMapper<>(Bbsc.class));
    return list;
  }

  /**
   * 검색
   * @param petType 펫태그(강아지,고양이,소동물,기타)
   * @return
   */
  @Override
  public Optional<Bbsc> findByPetType(String petType) {
    StringBuffer sql = new StringBuffer();
    sql.append("select * from where pet_type = :petType ");
    try{
      Map<String, String> param = Map.of("petType", petType);
      Bbsc bbsc = template.queryForObject(
          sql.toString(),
          param,
          BeanPropertyRowMapper.newInstance(Bbsc.class)
      );
      return Optional.of(bbsc);
    }catch (EmptyResultDataAccessException e){
      return Optional.empty();
    }
  }

  /**
   * 상세조회
   *
   * @param id 게시글 번호
   * @return
   */
  @Override
  public Bbsc findByBbscId(Long id) {
    return null;
  }

  /**
   * 삭제
   *
   * @param id 게시글 번호
   * @return 삭제건수
   */
  @Override
  public int deleteByBbscId(Long id) {
    return 0;
  }

  /**
   * 수정
   *
   * @param id   게시글 번호
   * @param bbsc 수정내용
   * @return 수정건수
   */
  @Override
  public int updateByBbscId(Long id, Bbsc bbsc) {
    return 0;
  }

  /**
   * 조회수 증가
   *
   * @param id 게시글 번호
   * @return 수정건수
   */
  @Override
  public int increaseHitCount(Long id) {
    return 0;
  }
}
