#import "NibTableViewCell.h"
#import "BFCUtility.h"

@implementation NibTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    self.nibLabel.numberOfLines = 0;
    self.backgroundColor = [UIColor clearColor];
    self.nibLabel.font = [BFCUtility bfcCellFont];
    self.nibLabel.textColor = [BFCUtility bfcCellFontColor];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)nibCellHeight {
    
    CGFloat topMargin = 10.0;
    CGFloat bottomMargin = 10.0;
    CGFloat imageHeight = 80.0;
    
    return topMargin + imageHeight + bottomMargin;
}

@end
